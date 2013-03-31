fs = require 'fs'
express = require 'express'
connect = require 'connect'

app = module.exports = express.createServer()
app.configure ->
  app.use connect.compress()
  app.use express.bodyParser()
  app.use app.router
  app.use express.static __dirname + '/public'
  app.disable 'x-powered-by'

handlebars = require 'handleify/node_modules/handlebars'
# handlebar templates on the server
require.extensions['.hbs'] = (module, filename) ->
  template = handlebars.compile fs.readFileSync filename, 'utf8'
  module.exports = (context) ->
    template context

index = require './index.html.hbs'

# express plugins
require('chalice-server')(app, index)
require('./express-api')(app)

# boot the app server side
require './override'
require './src/bootstrap'

module.exports = app
app.listen(3000)
