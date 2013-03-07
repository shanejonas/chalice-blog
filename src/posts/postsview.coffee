Backbone = require 'backbone'
$ = Backbone.$
template = require './posts.mustache'
post = require '../post/post.mustache'
Post = require '../post/postview'

class PostsView extends Backbone.A.CompositeView

  className: 'PostsView'

  getViews: ->
    return [] unless @collection?
    if not @views?.length > 0
      @views = (new Post model: model for model in @collection.models)
    @views

  template: template

  attach: ->
    @collection.on 'reset', @render, @
    super

module.exports = PostsView
