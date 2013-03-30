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

  describe 'client side', ->
    cheerio = require('cheerio')

    afterEach: ->
      Backbone.$ = null

    it 'renders data from a collection', ->
      Backbone.$ = cheerio.load('<body></body>')
      collection = new Backbone.Collection [{title: 'About', slug: 'about'}]
      view = new PostsView
        collection: collection
      result = view.render()
      result.$el.html().should.include 'About'

