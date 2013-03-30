Backbone = require 'backbone'
$ = Backbone.$
template = require './posts.hbs'
post = require '../post/post.hbs'
Post = require '../post/postview.coffee'
CompositeView = require 'chalice-compositeview'

class PostsView extends CompositeView

  initialize: ->
    @session = @options.session
    if @options.childViewType then @childViewType = @options.childViewType
    super

  afterRender: ->
    super
    afterRender = =>
      @getViews(yes)
      @render()
    @collection.on 'add', afterRender
    @collection.on 'remove', afterRender
    @collection.on 'reset', afterRender

  className: 'PostsView'

  childViewType: Post

  getViews: (force=no)->
    return @views unless @collection? or not force
    @views = (new @childViewType {model: model, parent: @, session: @session} for model in @collection.models)
    @views

  toHTML: ->
    @getViews()
    if @views.length > 0 then super else @wrap "Loading..."

  template: template

  remove: ->
    @stopListening @collection
    super

module.exports = PostsView
