Backbone = require 'backbone'
$ = Backbone.$
template = require './adminpostview.hbs'
Post = require '../post/postview.coffee'
_ = require 'underscore'

class AdminPostView extends Post

  template: template

  events:
    'click .button.edit': 'edit'
    'click .button.delete': 'delete'

  getTemplateData: ->
    _.extend @model?.toJSON(),
      url: "/posts/" + @model.get('slug')
      parent: @options.parent
      pubDate: moment(@model.get('updated_at')).format("dddd, MMMM Do YYYY");
      logged_in: @session?.get('logged_in')

  delete: (e)->
    @model.destroy()

  edit: (e)->
    Backbone.history.navigate "/posts/#{@model.get('slug')}/edit", trigger: yes


module.exports = AdminPostView
