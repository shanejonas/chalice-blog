Backbone = require 'backbone'
$ = Backbone.$
template = require './posts.hbs'
post = require '../post/post.hbs'
Post = require '../post/postview.coffee'
CompositeView = require 'anatomy-compositeview'

class PostsView extends CompositeView

  initialize: ->
    @collection.on 'reset', =>
      @getViews(yes)
      @render()
    , @

  className: 'PostsView'

  childViewType: Post

  getViews: (force=no)->
    return @views unless @collection? or not force
    @views = (new @childViewType {model: model, parent: @} for model in @collection.models)
    @views

  render: ->
    super
    view._ensureElement() for view in @views
    this

  toHTML: ->
    @getViews()
    if @views.length > 0 then super else @wrap "Loading..."

  template: template

  # render: ->
  #   @_ensureElement()
  #   if not Backbone.$? then return this
  #   super

module.exports = PostsView
