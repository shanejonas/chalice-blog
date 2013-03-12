Backbone = require 'backbone'
PostModel = require '../post/postmodel'

class PostsCollection extends Backbone.Collection

  url: "/api/posts"

  model: PostModel

  getOrMake: (slug) ->
    [post] = @where {slug}
    if not post
      post = new PostModel {slug}
      @add post, at: 0
    post

module.exports = PostsCollection
