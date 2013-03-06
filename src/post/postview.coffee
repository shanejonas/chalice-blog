Backbone = require 'backbone'
template = require '../post/post.mustache'
_ = require 'underscore'

class PostView extends Backbone.A.View

  getTemplateData: ->
    _.extend @model.toJSON(), url: "/posts/" + @model.get('id')

  template: template

  toHTML: ->
    @template @getTemplateData()

module.exports = PostView
