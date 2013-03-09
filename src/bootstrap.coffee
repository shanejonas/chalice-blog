Backbone = require 'backbone'
Backbone.$ ?= require 'jqueryify'
App = require './app/application'
app = new App
Backbone.$ ->
  Backbone.history.start pushState: yes
  $('body').html app.appView.el
