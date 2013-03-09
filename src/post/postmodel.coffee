Backbone = require 'backbone'
if Backbone.isServer then API = require '../../api'

class PostModel extends Backbone.Model

  urlRoot: -> "/api/posts"

  sync: (method, model, options)->
    if not Backbone.isServer
      super
    else
      switch method
        when "create"
          API.createPost @toJSON(), (err, resp)->
            options.success model, resp, options
        when "read"
          resp = API.getPostsById @get('id'), (err, resp)->
            options.success model, resp, options
        when "update"
          resp = API.updatePost @get('id'), @toJSON(), (err, resp)->
            options.success model, resp, options
        when "delete"
          resp = API.deletePost @get('id'), (err, resp)->
            options.success model, resp, options

module.exports = PostModel
