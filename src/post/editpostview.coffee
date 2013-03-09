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
    @model.set attrs
    @model.save()
    Backbone.history.navigate "/posts/#{@model.get('id')}", trigger: yes

  serialize: ->
    title: @$("input[name='title']").val()
    body: @$("textarea[name='body']").val()

  getTemplateData: ->
    _.extend @model.toJSON(),
      url: @model.url()

  template: template

module.exports = EditPostView
