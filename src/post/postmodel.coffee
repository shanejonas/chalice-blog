Backbone = require 'backbone'
if Backbone.isServer then API = require '../../api'

class PostModel extends Backbone.Model

  urlRoot: -> "/api/posts"

  sync: (method, model, options)->
    if not Backbone.isServer
      super
    else
      switch method
        when "read"
          resp = API.getPostsById(@get('id'))
      options.success model, resp, options

module.exports = PostModel
