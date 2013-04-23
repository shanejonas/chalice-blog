Backbone = require 'backbone'
try Backbone.$ = require '$' catch e
_ = require 'underscore'
Router = require 'chalice-client'
PostsView = require '../posts/postsview.coffee'
PostView = require '../post/postview.coffee'
PostsCollection = require '../posts/postscollection.coffee'
PagesCollection = require '../posts/pagescollection.coffee'
PostModel = require '../post/postmodel.coffee'
AdminPostView = require '../admin/adminpostview.coffee'
AdminPostsCollection = require '../admin/adminpostscollection.coffee'
EditPostView = require '../post/editpostview.coffee'
NavBarView = require '../navbar/navbarview.coffee'
LoginView = require '../login/loginview.coffee'
CompositeView = require 'chalice-compositeview'

class Application extends Router

  getAppView: ->
    new CompositeView

  getNavigationView: ->
    new NavBarView
      collection: @pages
      session: @session

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
    @session = new Backbone.Model
    # initialize embedded page data
    pages = []
    if window?.NavigationItems
      pages = window.NavigationItems
      window.NavigationItems = null
    @pages = new PagesCollection pages
    @appView.addView @getNavigationView()

    data = if _(window?.Data).isArray()
      window.Data
    else if _(window?.Data).isObject()
      [window.Data]
    else
      []
    window?.Data = null
    @posts = new PostsCollection data
    this

  routes:
    '': 'allPosts'
    'new': 'newPost'
    'posts/:slug/edit': 'editPost'
    'posts/:slug': 'postBySlug'
    'pages/:slug': 'pageBySlug'
    'posts': 'allPosts'
    'login': 'login'
    'admin': 'admin'

  auth: (cb)->
    callback = cb
    cb = =>
      @adminPosts or= new AdminPostsCollection
      callback()

    unless @session.get('logged_in') is yes
      @login('You must be logged in to view that page', cb)
    else
      cb()

  login: (msg, cb)->
    view = new LoginView
      model: @session
      message: msg
      cb: cb
    @fetcher()
    @swap view

  newPost: ->
    @auth =>
      view = new EditPostView
        collection: @adminPosts
        pages: @pages
      @swap view
      @fetcher()

  editPost: (slug) ->
    @auth =>
      if @session.get('logged_in')
        post = @adminPosts.getOrMake slug
      else
        post = @posts.getOrMake slug
      view = new EditPostView
        model: post
      @fetcher post
      @swap view

  postBySlug: (slug) ->
    if @session.get('logged_in')
      post = @adminPosts.getOrMake slug
    else
      post = @posts.getOrMake slug
    view = new PostView
      session: @session
      model: post
    @fetcher post
    @swap view

  pageBySlug: (slug) ->
    page = @pages.getOrMake slug
    view = new PostView
      model: page
    @fetcher page
    @swap view

  allPosts: ->
    view = new PostsView
      collection: @posts
    @fetcher @posts
    @swap view

  admin: ->
    @auth =>
      view = new PostsView
        childViewType: AdminPostView
        collection: @adminPosts
        session: @session
      @fetcher @adminPosts
      @swap view

module.exports = Application

makeApplication = ->
  new Application

Backbone.$? ->
  makeApplication()
  Backbone.history.start pushState: yes

makeApplication() if not Backbone.$
