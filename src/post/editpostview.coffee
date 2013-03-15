Backbone = require 'backbone'
$ = Backbone.$
template = require './editpost.hbs'
_ = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()
View = require 'anatomy-view'

if not Backbone.isServer
  FetchCodemirror = require '../commands/fetchcodemirror.coffee'
  toMarkdown = require('../../vendor/tomarkdown').toMarkdown
  Marked = require 'marked'
  Marked.setOptions highlight: (code, lang)->
    require('../../vendor/highlight').highlightAuto(code).value

class EditPostView extends View

  className: "EditPostView"

  events:
    'submit form': 'submit'
    'click .toggleVim': 'toggleVim'
    'click .toggleLines': 'toggleLines'

  compileMarkdown: ->
    markdown = @editor.getValue()
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
    @model?.on 'change', @render, @

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
          if e.type is 'keyup' then @compileMarkdown()
      @compileMarkdown()

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
    type: (@$ "select[name='type']").val()

  types: [
      type: 'article'
      title: 'Article'
    ,
      type: 'video'
      title: 'Video'
    ,
      type: 'audio'
      title: 'Audio'
    ,
      type: 'image'
      title: 'Image'
    ,
      type: 'link'
      title: 'Link'
    ,
      type: 'page'
      title: 'Page'
  ]

  # select the right type for option/select
  allTheRightType: ->
    if @model?
      for type in @types
        if type.type is @model.get('type')
          type.selected = yes
          break
    else
      @types[0].selected = yes

  getTemplateData: ->
    @allTheRightType()
    body = toMarkdown(@model?.get('body') or '')
    _.extend @model?.toJSON() or {},
      url: @model?.url()
      body: body
      types: @types

  template: template

module.exports = EditPostView
