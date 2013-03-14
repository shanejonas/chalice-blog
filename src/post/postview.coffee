Backbone = require 'backbone'
$ = Backbone.$
template = require './post.hbs'
_ = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()
moment = require 'moment'
View = require 'anatomy-view'

class PostView extends View

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
      pubDate: moment(@model.get('updated_at')).format("dddd, MMMM Do YYYY");

  template: template

module.exports = PostView
