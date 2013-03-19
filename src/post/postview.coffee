Backbone = require 'backbone'
$ = Backbone.$
template = require './post.hbs'
_ = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()
moment = require 'moment'
View = require 'anatomy-view'

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

  className: "PostView"

  getUniqueName: ->
    @model.get('slug')

  initialize: ->
    @session?.on 'change', @render, @
    @model?.on 'change', @render, @
    super

  getTemplateData: ->
    _.extend @model?.toJSON(),
      url: "/posts/" + @model.get('slug')
      parent: @options.parent
      pubDate: moment(@model.get('updated_at')).format("dddd, MMMM Do YYYY");
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

  # render: ->
  #   @_ensureElement()
  #   if not Backbone.$? then return this
  #   super

module.exports = PostView
