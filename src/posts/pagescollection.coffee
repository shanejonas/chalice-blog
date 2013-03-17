Backbone = require 'backbone'
PageModel =  require '../post/pagemodel.coffee'
_ = require 'underscore'

class PagesCollection extends Backbone.Collection

  model: PageModel

  getOrMake: (slug) ->
    if _(slug).isArray()
      [slug] = slug
    [post] = @where {slug}
    if not post
      post = new @model {slug}
      @add post, at: 0
    post

  url: "/api/pages"

module.exports = PagesCollection
