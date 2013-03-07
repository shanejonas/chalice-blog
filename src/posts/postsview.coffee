Backbone = require 'backbone'
$ = Backbone.$
template = require './posts.mustache'
post = require '../post/post.mustache'
Post = require '../post/postview'

class PostsView extends Backbone.A.CompositeView

  className: 'PostsView'

  childViewType: Post

  template: template

module.exports = PostsView
