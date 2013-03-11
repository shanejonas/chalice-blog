Backbone = require 'backbone'
$ = Backbone.$
if not Backbone.isServer? then require 'anatomy/anatomy_client'
PostsView = require '../posts/postsview'
PostView = require '../post/postview'
PostsCollection = require '../posts/postscollection'
PostModel = require '../post/postmodel'
EditPostView = require '../post/editpostview'
NavBarView = require '../navbar/navbarview'
LoginView = require '../login/loginview'

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
    @session = new Backbone.Model
    this

  routes:
    '': 'allPosts'
    'new': 'newPost'
    'posts/:slug/edit': 'editPost'
    'posts/:slug': 'postBySlug'
    'posts': 'allPosts'
    'login': 'login'

  auth: (cb)->
    unless @session.get('logged_in') is yes
      @login('You must be logged in to view that page', cb)
    else
      cb()

  login: (msg, cb)->
    view = new LoginView
      model: @session
      message: msg
      uniqueName: 'login_view'
      cb: cb
    @swap view
    @trigger 'doneFetch'

  newPost: ->
    @auth =>
      newModel = new PostModel
      @posts.add newModel, at: 0
      view = new EditPostView
        model: newModel
        uniqueName: 'new_post'
      @swap view
      @trigger 'doneFetch'

  editPost: (slug) ->
    @auth =>
      post = @posts.getOrMake slug
      view = new EditPostView
        model: post
        uniqueName: 'edit_post'
      @fetcher
        context: post
        callback: => @swap view

  postBySlug: (slug) ->
    post = @posts.getOrMake slug
    view = new PostView
      model: post
      uniqueName: 'post_by_id_view'
    @fetcher
      context: post
      callback: => @swap view

  allPosts: ->
    view = new PostsView
      collection: @posts
      uniqueName: 'posts_view'
    @fetcher
      context: @posts
      callback: => @swap view

module.exports = Application
