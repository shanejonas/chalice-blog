Backbone = require 'backbone'
$ = Backbone.$
Post = require '../post/postview.coffee'
_ = require 'underscore'

class AdminPostView extends Post

  events:
    'click .button.edit': 'edit'
    'click .button.delete': 'delete'

  getTemplateData: ->
    _.extend @model?.toJSON(),
      url: "/posts/" + @model.get('slug')
      parent: @options.parent
      pubDate: moment(@model.get('created_at')).format("dddd, MMMM Do YYYY");
      logged_in: @session?.get('logged_in')
      body: null
      media: null

  delete: (e)->
    @model.destroy()

  edit: (e)->
    Backbone.history.navigate "/posts/#{@model.get('slug')}/edit", trigger: yes


module.exports = AdminPostView
