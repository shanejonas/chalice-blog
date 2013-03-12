require('./override')
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

getAllPosts = (req, res)->
  API.getPosts (err, posts)->
    if err then res.send 404
    else res.send posts

getPostsBySlug = (req, res)->
  API.getPostsBySlug req.params.slug, (err, post)->
    if err then res.send 404, 'Post not found'
    else res.send post

module.exports = (app)->
  app.post '/api/login', auth
  app.delete '/api/posts/slug', auth, deletePost
  app.put '/api/posts/:slug', auth, updatePost
  app.post '/api/posts/:slug', auth, createPost
  app.post '/api/posts', auth, createPost
  app.get '/api/posts', getAllPosts
  app.get '/api/posts/:slug', getPostsBySlug
