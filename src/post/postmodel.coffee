Backbone = require 'backbone'
if Backbone.isServer then API = require '../../api'

class PostModel extends Backbone.Model

  idAttribute: '_id'

  url: (opts)->
    url = "/api/posts"
    slug = @get('slug')
    if slug
      url + "/#{slug}"
    else
      url

  sync: (method, model, options)->
    if not Backbone.isServer
      super
    else
      switch method
        when "create"
          API.createPost @toJSON(), (err, resp)->
            options.success model, resp, options
        when "read"
          resp = API.getPostsBySlug @get('slug'), (err, resp)->
            options.success model, resp, options
        when "update"
          resp = API.updatePost @get('slug'), @toJSON(), (err, resp)->
            options.success model, resp, options
        when "delete"
          resp = API.deletePost @get('slug'), (err, resp)->
            options.success model, resp, options

module.exports = PostModel
