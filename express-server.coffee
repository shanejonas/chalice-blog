fs = require 'fs'
express = require 'express'
connect = require 'connect'
app = express()

# TODO: only leave this in for development
lrSnippet = require('grunt-contrib-livereload/lib/utils').livereloadSnippet

app.configure ->
  app.use lrSnippet
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
# TODO: only 3000 for development
app.listen(3000)
console.log('listening on port 3000')
