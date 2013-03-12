Backbone = require 'backbone'

class PostModel extends Backbone.Model

  idAttribute: '_id'

  url: (opts)->
    url = "/api/posts"
    slug = @get('slug')
    if slug
      url + "/#{slug}"
    else
      url

module.exports = PostModel
