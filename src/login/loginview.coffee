Backbone = require 'backbone'
$ = Backbone.$
require '../../vendor/backbone.basicauth'
template = require './login.hbs'
_ = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()
View = require 'chalice-view'

class LoginView extends View

  className: "LoginView"

  initialize: (options={})->
    @errors = options.errors or []
    @cb = options.cb
    if options.message then @errors.push @options.message

  template: template

  events:
    'submit form': 'onSubmit'

  onSubmit: (e)->
    @errors = []
    e.preventDefault()
    attrs = @serialize()
    attrs.slug = _.slugify attrs.title
    Backbone.BasicAuth.set(attrs.username, attrs.password)
    @model.url = '/api/login'
    @model.save {},
      success: =>
        @errors = []
        @oldLogin = null
        if @cb
          @cb()
        else
          Backbone.history.navigate "/posts", trigger: yes
      error: =>
        @errors = ['Username and Password do not match']
        @oldLogin = {username: attrs.username, password: attrs.password}
        @render(yes)
        @oldLogin = null

  serialize: ->
    username: @$("input[name='username']").val()
    password: @$("input[name='password']").val()

  getTemplateData: ->
    {
      errors: @errors
      oldLogin: @oldLogin
    }


module.exports = LoginView
