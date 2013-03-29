Backbone = require 'backbone'
$ = Backbone.$
template = require './editpost.hbs'
_ = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()
View = require 'chalice-view'
PostView = require './postview.coffee'

if not Backbone.isServer
  FetchCodemirror = require '../commands/fetchcodemirror.coffee'
  toMarkdown = require('../../vendor/tomarkdown').toMarkdown
  Marked = require 'marked'
  Marked.setOptions highlight: (code, lang)->
    require('../../vendor/highlight').highlightAuto(code).value

class EditPostView extends View

  className: "EditPostView"

  events:
    'keyup': 'compileMarkdown'
    'change select': 'compileMarkdown'
    'submit form': 'submit'
    'click .toggleVim': 'toggleVim'
    'click .toggleLines': 'toggleLines'

  compileMarkdown: ->
    data = @serialize()
    data.slug = _.slugify data.title
    console.log data
    if @previewModel? then @previewModel.set data
    if @previewView then @previewView.remove()
    if not @model and @collection?
      @previewModel ?= new @collection.model data
    else
      @previewModel ?= new @model.constructor data
    @previewView ?= new PostView
      model: @previewModel
    @$('.preview').html @previewView.render().el

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
    @pages = @options.pages

  submit: (e)->
    e.preventDefault()
    attrs = @serialize()
    attrs.slug = _.slugify attrs.title
    if attrs.type is 'page'
      coll = @pages
    else
      coll = @collection
    if not @model and @collection?
      @model = new @collection.model
      coll.add @model, at: 0
    @model.set attrs
    @model.save()
    Backbone.history.navigate "/posts/#{@model.get('slug')}", trigger: yes

  initCodeMirror: ->
    area = (@$ "textarea")[0]
    if area
      @editor ?= CodeMirror.fromTextArea area,
        mode: 'markdown'
        lineNumbers: @lines
        lineWrapping: yes
        theme: "solarized dark"
        extraKeys: "Enter": "newlineAndIndentContinueMarkdownList"
      @compileMarkdown()

  loadCodeMirror: ->
    if Backbone.$
      if window?.loadedCodeMirror
        @initCodeMirror()
      else
        FetchCodemirror =>
          window?.loadedCodeMirror = yes
          @initCodeMirror()

  afterRender: ->
    super
    @model?.on 'change', => @render()
    @loadCodeMirror()

  serialize: ->
    title: (@$ "input[name='title']").val()
    body: Marked(@editor.getValue())
    type: (@$ "select[name='type']").val()
    media: (@$ "input[name='media']").val()

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

  remove: ->
    @previewView.remove()
    @previewModel = null
    @model?.off null, null, this
    super

module.exports = EditPostView
