Backbone = require 'backbone'
$ = Backbone.$
if not Backbone.isServer? then require 'anatomy/anatomy_client'
PostsView = require '../posts/postsview'
PostView = require '../post/postview'
PostsCollection = require '../posts/postscollection'
PostModel = require '../post/postmodel'
EditPostView = require '../post/editpostview'
NavBarView = require '../navbar/navbarview'

config = require './config'

class Application extends Backbone.Router

  uniqueName: 'app'

  getNavigationView: ->
    new NavBarView
      collection: new Backbone.Collection config.navigationItems

  initialize: ->
    @appView.addView @getNavigationView()
    data = window?.Data or []
    @posts = new PostsCollection data
    this

  routes:
    '': 'default'
    'new': 'newPost'
    'posts/:slug/edit': 'editPost'
    'posts/:slug': 'post'
    'posts': 'default'

  newPost: ->
    newModel = new PostModel
    @posts.add newModel
    view = new EditPostView
      model: newModel
      uniqueName: 'new_post'
    @swap view
    @trigger 'doneFetch'

  editPost: (slug) ->
    post = @posts.getOrMake slug
    view = new EditPostView
      model: post
      uniqueName: 'edit_post'
    @fetcher
      context: post
      callback: => @swap view

  post: (slug) ->
    post = @posts.getOrMake slug
    view = new PostView
      model: post
      uniqueName: 'post_by_id_view'
    @fetcher
      context: post
      callback: => @swap view

  default: ->
    view = new PostsView
      collection: @posts
      uniqueName: 'posts_view'
    @fetcher
      context: @posts
      callback: => @swap view

module.exports = Application
