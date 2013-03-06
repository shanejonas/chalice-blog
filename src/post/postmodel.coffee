Backbone = require 'backbone'

class PostModel extends Backbone.Model

  urlRoot: -> "/api/post"

  sync: (method, model, options)->
    if not Backbone.isServer
      super
    else
      switch method
        when "read"
          resp = API.getPostsById(@get('id'))
      options.success model, resp, options

module.exports = PostModel
