Backbone = require 'backbone'
$ = Backbone.$
template = require './editpost.mustache'
_ = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()

if not Backbone.isServer
  Codemirror = require '../../vendor/codemirror/codemirror'
  require '../../vendor/codemirror/continuelist'
  require '../../vendor/codemirror/xml'
  require '../../vendor/codemirror/markdown'
  require '../../vendor/codemirror/vim'

class EditPostView extends Backbone.A.View

  className: "EditPostView"

  events:
    'submit form': 'submit'
    'click .toggleVim': 'toggleVim'
    'click .toggleLines': 'toggleLines'

  toggleVim: (e)->
    if @vim
      @editor.setOption 'keyMap', 'default'
    else
      @editor.setOption 'keyMap', 'vim'
    @vim = !@vim

  toggleLines: (e)->
    @editor.setOption 'lineNumbers', !@lines
    @lines = !@lines

  initialize: ->
    @vim = no
    @lines = no
    super

  submit: (e)->
    e.preventDefault()
    attrs = @serialize()
    attrs.slug = _.slugify attrs.title
    @model.set attrs
    @model.save()
    Backbone.history.navigate "/posts/#{@model.get('slug')}", trigger: yes

  attach: ->
    super
    area = @$("textarea")[0]
    if area
      @editor ?= CodeMirror.fromTextArea @$("textarea")[0],
        mode: 'markdown'
        lineNumbers: @lines
        theme: "solarized dark"
        extraKeys: "Enter": "newlineAndIndentContinueMarkdownList"

  serialize: ->
    title: @$("input[name='title']").val()
    body: @$("textarea[name='body']").val()

  getTemplateData: ->
    _.extend @model.toJSON(),
      url: @model.url()

  template: template

module.exports = EditPostView
