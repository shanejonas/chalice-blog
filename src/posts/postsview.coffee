Backbone = require 'backbone'
$ = Backbone.$
template = require './posts.hbs'
post = require '../post/post.hbs'
Post = require '../post/postview.coffee'
CompositeView = require 'anatomy-compositeview'

class PostsView extends CompositeView

  className: 'PostsView'

  childViewType: Post

  toHTML: ->
    @getViews()
    if @views.length > 0 then super else @wrap "No Posts."

  template: template

module.exports = PostsView
