Backbone = require 'backbone'
Backbone.$ ?= require 'jqueryify'
App = require './app/application'
new App
Backbone.$ -> Backbone.history.start pushState: yes
