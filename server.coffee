express = require 'express'
fs = require 'fs'
app = module.exports = express.createServer()
app.configure ->
  app.use express.bodyParser()
  app.use app.router
  app.use express.static __dirname + '/public'
  app.disable 'x-powered-by'

_ = require 'underscore'
handlebars = require 'handleify/node_modules/handlebars'
# handlebar templates on the server
require.extensions['.hbs'] = (module, filename) ->
  template = handlebars.compile fs.readFileSync filename, 'utf8'
  module.exports = (context) ->
    template context

index = require './index.html.hbs'

# TODO: move this code into anatomy-server
# require('anatomy-server')(app, index)
Backbone = require 'backbone'
Backbone.$ = null
Backbone.isServer = yes

require 'anatomy-shared'

# Override the `route` function to bind to express instead.
Backbone.Router::route = (route, name) ->
  # Manually add the route to the beginning supersceding the rest of the
  # already added routes.
  app.get '/' + route, (req, res) =>
    render = =>
      model = @appView.views[1].model
      collection = @appView.views[1].collection
      template = index
        markup: @appView.toHTML(yes)
        navigationItems: JSON.stringify @appView.views[0].collection.toJSON()
        model: JSON.stringify model or collection
      res.end template
    @off('doneFetch', render).on 'doneFetch', render
    @[name] _.values(req.params)

Backbone.Router::swap = (view)->
  @oldView = @view if @view
  @appView.removeView @oldView if @oldView
  @view = view
  @appView.addView view
  @oldView = null
  @firstBoot = no

# end anatomy-server

require('./src/bootstrap')

# require server-specific code
require './override'

API = require './api'
auth = require './basic-auth'

createPost = (req, res)->
  redirect = no
  if req.body.fromform
    redirect = yes
    delete req.body.fromform
  API.createPost req.body, (err, post)->
    if err then res.send 404
    else
      if redirect
        res.redirect "/posts/#{post.slug}"
      else
        res.send post

deletePost = (req, res)->
  API.deletePost req.params.slug, (err)->
    if err then res.send 404
    else res.send 200

updatePost = (req, res)->
  if req.body.fromform
    redirect = yes
    delete req.body.fromform
  API.updatePost req.params.slug, req.body, (err, post)->
    if err then res.send 404
    else
      if redirect
        res.redirect "/posts/#{req.params.id}"
      else
        res.send post

getPosts = (req, res)->
  API.getPosts (err, posts)->
    if err then res.send 404
    else res.send posts

getPostBySlug = (req, res)->
  API.getPostBySlug req.params.slug, (err, post)->
    if err then res.send 404, 'Post not found'
    else res.send post

getPages = (req, res)->
  API.getPages (err, posts)->
    if err then res.send 404
    else res.send posts

app.post '/api/login', auth
app.delete '/api/posts/slug', auth, deletePost
app.put '/api/posts/:slug', auth, updatePost
app.post '/api/posts/:slug', auth, createPost
app.post '/api/posts', auth, createPost
app.get '/api/posts', getPosts
app.get '/api/posts/:slug', getPostBySlug
app.get '/api/pages', getPages
app.get '/api/pages/:slug', getPostBySlug

app.listen(3000)
module.exports = app
