Backbone = require 'backbone'
$ = Backbone.$
template = require './post.mustache'
_ = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()

class PostView extends Backbone.A.View

  className: "PostView"

  getUniqueName: ->
    @model.get('slug')

  attach: ->
    super
    @model.off(null, null, this).on 'change', (=> @render(yes)), @

  getTemplateData: ->
    body = @model.get('body')
    body = if @options.parent then _(body).prune(200) else body
    _.extend @model?.toJSON(),
      url: "/posts/" + @model.get('slug')
      parent: @options.parent
      # prune body text if you are in a list
      body: body

  template: template

module.exports = PostView
