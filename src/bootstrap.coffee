Backbone = require 'backbone'
Backbone.$ ?= require('../vendor/zepto')
App = require './app/application.coffee'
app = new App
Backbone.$ ->
  Backbone.history.start pushState: yes
  app.appView.attach()
