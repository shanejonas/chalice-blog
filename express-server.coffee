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
app.listen(3000)

handlebars = require 'handleify/node_modules/handlebars'
# handlebar templates on the server
require.extensions['.hbs'] = (module, filename) ->
  template = handlebars.compile fs.readFileSync filename, 'utf8'
  module.exports = (context) ->
    template context

index = require './index.html.hbs'
require('chalice-server')(app, index)
require('./src/bootstrap')
require './override'
require('./express-api')(app)
module.exports = app
