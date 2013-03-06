Backbone = require 'backbone'
PostModel = require '../post/postmodel'
if Backbone.isServer then API = require '../../api'

class PostsCollection extends Backbone.Collection

  url: "/api/posts"

  model: PostModel

  sync: (method, model, options)->
    if not Backbone.isServer
      super method, model, options
    else
      switch method
        when "read"
          resp = API.getPosts()
      options.success model, resp, options

module.exports = PostsCollection
