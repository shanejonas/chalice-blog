Backbone = require 'backbone'

describe 'NavBarView', ->

  NavBarView = require '../../src/navbar/navbarview'

  it 'exists', ->
    NavBarView.should.be.a.function

  it 'renders data from a collection', ->
    collection = new Backbone.Collection [{title: 'About', slug: 'about'}]
    view = new NavBarView
      collection: collection
    result = view.toHTML()
    result.should.include 'About'

  it 'has a className', ->
    collection = new Backbone.Collection [{title: 'About', slug: 'about'}]
    view = new NavBarView
    view.className.should.equal 'NavBarView'
