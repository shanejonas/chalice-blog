Backbone = require 'backbone'
$ = Backbone.$
template = require './editpost.mustache'
_ = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()

class EditPostView extends Backbone.A.View

  className: "EditPostView"

  events:
    'submit form': 'submit'

  submit: (e)->
    e.preventDefault()
    attrs = @serialize()
    attrs.slug = _.slugify attrs.title
    @model.set attrs
    @model.save()
    Backbone.history.navigate "/posts/#{@model.get('slug')}", trigger: yes

  serialize: ->
    title: @$("input[name='title']").val()
    body: @$("textarea[name='body']").val()

  getTemplateData: ->
    _.extend @model.toJSON(),
      url: @model.url()

  template: template

module.exports = EditPostView
