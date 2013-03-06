Backbone = require 'backbone'
template = require './posts.mustache'
post = require '../post/post.mustache'
Post = require '../post/postview'

class PostsView extends Backbone.A.View

  template: template

  getViews: ->
    if not @views
      @views = (new Post model: model for model in @collection.models)
    @views

  render: ->
    views = @getViews()

  toHTML: ->
    views = @getViews()
    posts = (view.toHTML() for view in views)
    @template posts: posts.join ''

module.exports = PostsView
