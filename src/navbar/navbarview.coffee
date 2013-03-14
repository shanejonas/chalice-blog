Backbone = require 'backbone'
$ = Backbone.$
template = require './navbar.hbs'
_ = require 'underscore'
View = require 'anatomy-view'

class NavBarView extends View

  className: "NavBarView"

  template: template

  getTemplateData: ->
    items: @collection.toJSON()

module.exports = NavBarView
