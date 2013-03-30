View = require 'chalice-view'
template = require './navbar.hbs'

class NavbarView extends View

  initialize: ->
    @session = @options.session
    @collection?.on 'reset', @render, @

  className: "NavBarView"

  template: template

  getTemplateData: ->
    items: @collection?.toJSON()
    logged_in: @session?.get('logged_in')

module.exports = NavbarView
