Backbone = require 'backbone'
template = require './posts.mustache'
post = require '../post/post.mustache'
Post = require '../post/postview'

class PostsView extends Backbone.A.View

  className: 'PostsView'

  template: template

  getViews: ->
    console.log @collection.models
    if not @views?.length > 0
      @views = (new Post model: model for model in @collection.models)
    @views

  attach: ->
    @collection.on 'reset', @render, @

  render: ->
    @$el.html @toHTML()
    @attach()
    this

  toHTML: ->
    views = @getViews()
    posts = (view.toHTML() for view in views)
    console.log posts
    @template posts: posts.join ''

module.exports = PostsView
