Backbone = require 'backbone'
PostModel = require '../post/postmodel'
if Backbone.isServer then API = require '../../api'

class PostsCollection extends Backbone.Collection

  url: "/api/posts"

  model: PostModel

  getOrMake: (slug) ->
    [post] = @where {slug}
    if not post
      post = new PostModel {slug}
      @add post, at: 0
    post

  sync: (method, model, options)->
    if not Backbone.isServer
      super method, model, options
    else
      switch method
        when "create"
          API.createPost @toJSON(), (err, resp)->
            options.success model, resp, options
        when "read"
          resp = API.getPosts (err, resp)->
            options.success model, resp, options
        when "update"
          resp = API.updatePost @get('slug'), @toJSON(), (err, resp)->
            options.success model, resp, options
        when "delete"
          resp = API.deletePost @get('slug'), (err, resp)->
            options.success model, resp, options

module.exports = PostsCollection
