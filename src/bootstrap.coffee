Backbone = require 'backbone'
if not Backbone.isServer then Backbone.$ = require('../vendor/zepto')
App = require './app/application.coffee'

if not Backbone.$
  app = new App
else
  # wait for the dom so we can attach on constructor
  Backbone.$ ->
    app = new App
    Backbone.history.start pushState: yes
