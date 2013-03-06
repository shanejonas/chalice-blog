API = require './api'

module.exports = (app)->

  app.get '/api/posts', (req, res)->
    res.send API.getPosts()

  app.get '/api/posts/:id', (req, res)->
    res.send API.getPostsById(req.params.id)
