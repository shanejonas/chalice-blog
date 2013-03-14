Backbone = require 'backbone'
console.log 'Backbone.$', Backbone.$, Backbone.isServer

Backbone.$ ?= require('../vendor/zepto')
App = require './app/application.coffee'
app = new App
Backbone.$ ->
  Backbone.history.start pushState: yes
  app.appView.attach()
