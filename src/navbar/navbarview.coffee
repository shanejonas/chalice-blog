Backbone = require 'backbone'
$ = Backbone.$
template = require './navbar.mustache'
_ = require 'underscore'

class NavBarView extends Backbone.A.View

  className: "NavBarView"

  template: template

  getTemplateData: ->
    items: @collection.toJSON()

module.exports = NavBarView
