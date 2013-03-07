Backbone = require 'backbone'
$ = Backbone.$
template = require '../post/post.mustache'
_ = require 'underscore'

class PostView extends Backbone.A.View

  className: "PostView"

  getTemplateData: ->
    _.extend @model?.toJSON(), url: "/posts/" + @model.get('id')

  template: template

module.exports = PostView
