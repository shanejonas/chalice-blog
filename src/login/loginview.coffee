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
    console.log options.message
    if options.message then @errors.push @options.message
    super

  # events:
  #   '#form submit': (e)->
  #     e.preventDefault()
  #     console.log 'SUBMITTED FORM'

  attach: ->
    super
    # FIXME: should be in events hash
    @$('form').off().on 'submit', ((e)=> @onSubmit(e))

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
        console.log 'LOGGED IN!'
        Backbone.history.navigate "/posts", trigger: yes
      error: =>
        @errors = ['Username and Password do not match']
        @render(yes)
        console.log 'NOT LOGGED IN!'

  serialize: ->
    username: @$("input[name='username']").val()
    password: @$("input[name='password']").val()

  getTemplateData: ->
    {errors: @errors}

  template: template

module.exports = LoginView
