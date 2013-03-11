Backbone = require 'backbone'
$ = Backbone.$
template = require './editpost.mustache'
_ = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()

if not Backbone.isServer
  FetchCodemirror = require '../commands/fetchcodemirror'
  toMarkdown = require('../../vendor/tomarkdown').toMarkdown
  Marked = require 'marked'
  Marked.setOptions highlight: (code, lang)->
    require('../../vendor/highlight').highlightAuto(code).value

class EditPostView extends Backbone.A.View

  className: "EditPostView"

  events:
    'submit form': 'submit'
    'click .toggleVim': 'toggleVim'
    'click .toggleLines': 'toggleLines'

  compileMarkdown: (markdown)->
    result = Marked(markdown)
    @$('.preview').html result

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
    if not @model and @collection?
      @model = new @collection.model
      @collection.add @model, at: 0
    @model.set attrs
    @model.save()
    Backbone.history.navigate "/posts/#{@model.get('slug')}", trigger: yes

  initCodeMirror: ->
    area = (@$ "textarea")[0]
    if area
      @editor ?= CodeMirror.fromTextArea @$("textarea")[0],
        mode: 'markdown'
        lineNumbers: @lines
        theme: "solarized dark"
        extraKeys: "Enter": "newlineAndIndentContinueMarkdownList"
        onKeyEvent: (editor, e)=>
          if e.type is 'keyup'
            markdown = editor.getValue()
            @compileMarkdown(markdown)

  loadCodeMirror: ->
    if window?.loadedCodeMirror
      @initCodeMirror()
    else
      FetchCodemirror =>
        window?.loadedCodeMirror = yes
        @initCodeMirror()

  attach: ->
    super
    @loadCodeMirror()

  serialize: ->
    title: (@$ "input[name='title']").val()
    body: Marked(@editor.getValue())



  getTemplateData: ->
    body = toMarkdown(@model?.get('body') or '')
    _.extend @model?.toJSON() or {},
      url: @model?.url()
      body: body

  template: template

module.exports = EditPostView
