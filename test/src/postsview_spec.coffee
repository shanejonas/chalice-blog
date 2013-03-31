Backbone = require 'backbone'

describe 'PostsView', ->

  PostsView = require '../../src/posts/postsview'

  it 'exists', ->
    PostsView.should.be.a.function

  it 'renders data from a collection', ->
    collection = new Backbone.Collection [{title: 'About', slug: 'about'}]
    view = new PostsView
      collection: collection
    result = view.toHTML()
    result.should.include 'About'

  it 'has a className', ->
    collection = new Backbone.Collection [{title: 'About', slug: 'about'}]
    view = new PostsView
    view.className.should.equal 'PostsView'
