Backbone = require 'backbone'
$ = Backbone.$
if not Backbone.isServer? then require 'anatomy/anatomy_client'
PostsView = require '../posts/postsview'
PostView = require '../post/postview'
PostsCollection = require '../posts/postscollection'

class Application extends Backbone.Router

  initialize: ->
    posts = [
        id: 1
        title: 'Post Title'
        body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent molestie lobortis purus, quis interdum arcu cursus nec. Pellentesque eget massa nisi. Nulla facilisi. Vestibulum bibendum convallis ligula ut mattis. Vestibulum sed metus tortor, ut malesuada tellus. Donec convallis turpis et mi dictum venenatis. Maecenas accumsan vestibulum erat, non hendrerit sem convallis ac.'
      ,
        id: 2
        title: 'Other Post Title'
        body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent molestie lobortis purus, quis interdum arcu cursus nec. Pellentesque eget massa nisi. Nulla facilisi. Vestibulum bibendum convallis ligula ut mattis. Vestibulum sed metus tortor, ut malesuada tellus. Donec convallis turpis et mi dictum venenatis. Maecenas accumsan vestibulum erat, non hendrerit sem convallis ac.'
    ]
    @posts = new PostsCollection posts

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
