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
require('anatomy-server')(app, index)
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
