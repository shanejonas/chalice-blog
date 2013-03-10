Backbone = require 'backbone'
$ = Backbone.$
require '../../vendor/backbone.basicauth'
template = require './login.mustache'
_ = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()

class LoginView extends Backbone.A.View

  className: "LoginView"

  initialize: (options={})->
    @errors = options.errors or []
    if options.message then @errors.push @options.message
    super

  events:
    # stupid form submit isnt working
    # 'form submit': 'onSubmit'
    'click #submit': 'onSubmit'
    'keyup input': 'checkEnter'

  checkEnter: (e)->
    if event.keyCode is 13
      @onSubmit(e)

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

  template: template

module.exports = LoginView
