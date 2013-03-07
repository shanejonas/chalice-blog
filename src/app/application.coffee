Backbone = require 'backbone'
$ = Backbone.$
if not Backbone.isServer? then require 'anatomy/anatomy_client'
PostsView = require '../posts/postsview'
PostView = require '../post/postview'
PostsCollection = require '../posts/postscollection'
PostModel = require '../post/postmodel'

class Application extends Backbone.Router

  initialize: ->
    data = window?.Data or []
    @posts = new PostsCollection data
    this

  routes:
    '': 'default'
    'posts': 'default'
    'posts/:id': 'post'

  post: (id)->
    @fetcher
      context: @posts
      callback: =>
        view = new PostView
          model: @posts.get id
        @swap view

  default: ->
    view = new PostsView
      collection: @posts
    @fetcher
      context: @posts
      callback: =>
        @swap view

module.exports = Application
