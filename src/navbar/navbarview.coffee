View = require 'chalice-view'
template = require './navbar.hbs'

class NavbarView extends View

  initialize: ->
    @collection?.on 'reset', @render, @

  className: "NavBarView"

  template: template

  getTemplateData: ->
    items: @collection?.toJSON()

module.exports = NavbarView
