Backbone = require 'backbone'
$ = Backbone.$
template = require '../post/post.mustache'
_ = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()

class PostView extends Backbone.A.View

  className: "PostView"

  getTemplateData: ->
    body = @model.get('body')
    _.extend @model?.toJSON(),
      url: "/posts/" + @model.get('id')
      parent: @options.parent
      # prune body text if you are in a list
      body: if @options.parent then _(body).prune(200) else body

  template: template

module.exports = PostView
