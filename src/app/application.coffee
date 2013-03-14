Backbone = require 'backbone'
$ = Backbone.$
if not Backbone.isServer? then require 'anatomy-client'
PostsView = require '../posts/postsview.coffee'
PostView = require '../post/postview.coffee'
PostsCollection = require '../posts/postscollection.coffee'
PostModel = require '../post/postmodel.coffee'
EditPostView = require '../post/editpostview.coffee'
NavBarView = require '../navbar/navbarview.coffee'
LoginView = require '../login/loginview.coffee'

config = require './config.coffee'

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
      view = new EditPostView
        collection: @posts
        uniqueName: 'new_post'
      @swap view
      @trigger 'doneFetch'

  editPost: (slug) ->
    @auth =>
      post = @posts.getOrMake slug
      view = new EditPostView
        model: post
        uniqueName: 'edit_post'
      @fetcher context: post
      @swap view

  postBySlug: (slug) ->
    post = @posts.getOrMake slug
    view = new PostView
      model: post
      uniqueName: 'post_by_id_view'
    @fetcher context: post
    @swap view

  allPosts: ->
    view = new PostsView
      collection: @posts
      uniqueName: 'posts_view'
    @fetcher context: @posts
    @swap view

module.exports = Application
