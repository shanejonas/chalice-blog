Backbone = require 'backbone'
$ = Backbone.$
template = require './post.hbs'
_ = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()
moment = require 'moment'
View = require 'chalice-view'

templateTypes =
  audio: require './types/audio.hbs'
  video: require './types/video.hbs'
  image: require './types/image.hbs'
  page: require './types/page.hbs'
  link: require './types/link.hbs'
  article: template

class PostView extends View

  initialize: ->
    @session = @options.session
    super

  events:
    'click .button.edit': 'edit'
    'click .button.delete': 'delete'

  className: "PostView"

  getUniqueName: ->
    @model.get('slug')

  afterRender: ->
    super
    if @model
      @stopListening @model, ['change']
      @listenTo @model, 'change', => @render()
    if @session
      @stopListening @session, ['change']
      @listenTo @session, 'change', => @render()

  getTemplateData: ->
    _.extend @model?.toJSON(),
      url: "/posts/" + @model.get('slug')
      parent: @options.parent
      pubDate: moment(@model.get('created_at')).format("dddd, MMMM Do YYYY");
      body: if @options.parent then null else @model.get('body')
      logged_in: @session?.get('logged_in')

  template: (data)->
    type = @model?.get('type')
    if type
      templateTypes[@model.get('type')](data)
    else
      template(data)

  remove: ->
    @session = null
    super

  delete: (e)->
    @model.destroy()
    Backbone.history.navigate "/admin", trigger: yes

  edit: (e)->
    Backbone.history.navigate "/posts/#{@model.get('slug')}/edit", trigger: yes

module.exports = PostView
