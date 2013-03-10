#// @browserify-ignore
API = require './api'

module.exports = (app)->
  app.delete '/api/posts/:id', (req, res)->
    API.deletePost req.params.id, (err)->
      if err then res.send 404
      else res.send 200

  app.post '/api/posts/:id', (req, res)->
    API.updatePost req.params.id, req.body, (err, post)->
      if err then res.send 404
      else
        if req.body.fromform
          res.redirect "/posts/#{req.params.id}"
        else
          res.send post

  app.put '/api/posts/:id', (req, res)->
    API.updatePost req.params.id, req.body, (err, post)->
      if err then res.send 404
      else
        if req.body.fromform
          res.redirect "/posts/#{req.params.id}"
        else
          res.send post

  app.post '/api/posts', (req, res)->
    API.createPost req.body, (err, post)->
      if err then res.send 404
      else
        if req.body.fromform
          res.redirect "/posts/#{post.id}"
        else
          res.send post

  app.get '/api/posts', (req, res)->
    API.getPosts (err, posts)->
      if err then res.send 404
      else res.send posts

  app.get '/api/posts/:id', (req, res)->
    API.getPostsById req.params.id, (err, post)->
      if err then res.send 404
      else res.send post
