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
    _.extend @model?.toJSON(),
      url: "/posts/" + @model.get('slug')
      parent: @options.parent
      pubDate: moment(@model.get('updated_at')).format("dddd, MMMM Do YYYY");

  template: template

module.exports = PostView
