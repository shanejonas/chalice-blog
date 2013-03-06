Backbone = require 'backbone'
PostModel = require '../post/postmodel'

class PostsCollection extends Backbone.Collection

  model: PostModel

module.exports = PostsCollection
