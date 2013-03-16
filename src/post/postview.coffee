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

  attach: ->
    super
    @session?.off(null, null, this).on 'change', (=> @render(yes)), @
    @model.off(null, null, this).on 'change', (=> @render(yes)), @

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
    @$('video')[0]?.pause()?.remove()
    @$('autio')[0]?.pause()?.remove()
    super

  render: (force=no)->
    elExists = @elementExistsInDom()
    if force then @_shouldRedraw = yes
    if elExists then @attach()
    @$el.html @toHTML not @elementExistsInDom() or force
    if not elExists then @attach()
    @_shouldRedraw = no
    this

module.exports = PostView
