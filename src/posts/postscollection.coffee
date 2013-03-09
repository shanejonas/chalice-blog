Backbone = require 'backbone'
PostModel = require '../post/postmodel'
if Backbone.isServer then API = require '../../api'

class PostsCollection extends Backbone.Collection

  url: "/api/posts"

  model: PostModel

  getOrMake: (id) ->
    if @get(id)
      post = @get id
    else
      post = new PostModel {id}
      @add post
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
          resp = API.updatePost @get('id'), @toJSON(), (err, resp)->
            options.success model, resp, options
        when "delete"
          resp = API.deletePost @get('id'), (err, resp)->
            options.success model, resp, options

module.exports = PostsCollection
