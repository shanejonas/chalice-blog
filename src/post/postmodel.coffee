Backbone = require 'backbone'

class PostModel extends Backbone.Model

  url: -> "post/#{@get('id')}"

  sync: (method, model, options)->
    if not Backbone.isServer
      super
    else
      switch method
        when "read"
          resp = API.getPostsById(@get('id'))
      options.success model, resp, options

module.exports = PostModel
