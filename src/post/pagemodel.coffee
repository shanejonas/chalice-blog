Backbone = require 'backbone'

class PageModel extends Backbone.Model

  idAttribute: '_id'

  url: (opts)->
    url = "/api/pages"
    slug = @get('slug')
    if slug
      url + "/#{slug}"
    else
      url

module.exports = PageModel
