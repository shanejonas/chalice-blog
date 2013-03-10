API = require './api'

createPost = (req, res)->
  API.createPost req.body, (err, post)->
    if err then res.send 404
    else
      if req.body.fromform
        res.redirect "/posts/#{post.slug}"
      else
        res.send post

deletePost = (req, res)->
  API.deletePost req.params.slug, (err)->
    if err then res.send 404
    else res.send 200

updatePost = (req, res)->
  API.updatePost req.params.slug, req.body, (err, post)->
    if err then res.send 404
    else
      if req.body.fromform
        res.redirect "/posts/#{req.params.id}"
      else
        res.send post

getAllPosts = (req, res)->
  API.getPosts (err, posts)->
    if err then res.send 404
    else res.send posts

getPostsBySlug = (req, res)->
  API.getPostsBySlug req.params.slug, (err, post)->
    if err then res.send 404
    else res.send post

module.exports = (app)->
  app.delete '/api/posts/slug', deletePost
  app.put '/api/posts/:slug', updatePost
  app.post '/api/posts/:slug', createPost
  app.post '/api/posts', createPost
  app.get '/api/posts', getAllPosts
  app.get '/api/posts/:slug', getPostsBySlug
