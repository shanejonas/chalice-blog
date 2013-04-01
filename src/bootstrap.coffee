Backbone = require 'backbone'
if not Backbone.isServer then Backbone.$ = require('../vendor/zepto')
App = require './app/application.coffee'

if not Backbone.$
  app = new App
else
  # expose window.Backbone for backbone-devtools chrome extension
  window.Backbone = Backbone
  # wait for the dom so we can attach on constructor
  Backbone.$ ->
    app = new App
    Backbone.history.start pushState: yes
