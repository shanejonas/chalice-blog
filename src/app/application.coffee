Backbone = require 'backbone'
$ = Backbone.$
_ = require 'underscore'
if not Backbone.isServer? then require 'anatomy-client'
PostsView = require '../posts/postsview.coffee'
PostView = require '../post/postview.coffee'
PostsCollection = require '../posts/postscollection.coffee'
PagesCollection = require '../posts/pagescollection.coffee'
PostModel = require '../post/postmodel.coffee'
EditPostView = require '../post/editpostview.coffee'
NavBarView = require '../navbar/navbarview.coffee'
LoginView = require '../login/loginview.coffee'

class Application extends Backbone.Router

  uniqueName: 'app'

  getNavigationView: ->
    new NavBarView
      collection: @pages

  # multi fetcher for navCollection
  fetcher: (contexts, callback)->
    if not _(contexts).isArray()
      if contexts
        contexts = [contexts]
      else
        contexts = []
    if @firstBoot and @pages isnt contexts[0] or @pages isnt contexts[0]?.collection
      contexts.push @pages
    cb = _.after contexts.length, =>
      @trigger 'doneFetch'
      callback?()
    context.fetch(success: cb) for context in contexts

  initialize: ->
    @pages = new PagesCollection
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
    'pages/:slug': 'pageBySlug'
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
    @fetcher()
    @swap view

  newPost: ->
    @auth =>
      view = new EditPostView
        collection: @posts
        uniqueName: 'new_post'
      @swap view
      @fetcher()

  editPost: (slug) ->
    @auth =>
      post = @posts.getOrMake slug
      view = new EditPostView
        model: post
        uniqueName: 'edit_post'
      @fetcher post
      @swap view

  postBySlug: (slug) ->
    post = @posts.getOrMake slug
    view = new PostView
      model: post
      uniqueName: 'post_by_id_view'
    @fetcher post
    @swap view

  pageBySlug: (slug) ->
    page = @pages.getOrMake slug
    view = new PostView
      model: page
      uniqueName: 'page_by_id_view'
    @fetcher page
    @swap view

  allPosts: ->
    view = new PostsView
      collection: @posts
      uniqueName: 'posts_view'
    @fetcher @posts
    @swap view

module.exports = Application
