Backbone = require 'backbone'
$ = Backbone.$
if not Backbone.isServer? then require 'anatomy/anatomy_client'
PostsView = require '../posts/postsview'
PostView = require '../post/postview'
PostsCollection = require '../posts/postscollection'

class Application extends Backbone.Router

  initialize: ->
    @posts = new PostsCollection posts
    @posts.fetch()

  routes:
    '': 'default'
    'posts': 'default'
    'posts/:id': 'post'

  post: (id)->
    view = new PostView
      model: @posts.get id
    @swap view

  default: ->
    view = new PostsView
      collection: @posts
    @swap view

module.exports = Application
