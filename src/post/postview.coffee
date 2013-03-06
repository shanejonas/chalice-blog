Backbone = require 'backbone'
template = require '../post/post.mustache'

class PostView extends Backbone.A.View

  template: template

  toHTML: ->
    @template @model.toJSON()

module.exports = PostView
