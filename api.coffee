Model = require('mongo-model')
_ = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()

class global.Post extends Model
  @collection 'posts'

clean = (obj)->
  if _(obj).isArray()
    clean item for item in obj
  else
    delete obj._originalDoc
    obj

module.exports =
  deletePost: (slug, callback)->
    Post.delete {slug: slug}, (err) ->
      if err then callback err
      else callback null

  updatePost: (slug, post, callback)->
    post.updated_at = new Date()
    Post.update {slug}, post, (err) ->
      if err then callback err
      else callback null

  createPost: (post, callback)->
    post.slug = _.slugify post.title
    post.created_at = new Date()
    post.updated_at = new Date()
    Post.create post, (err, _post) ->
      if err then callback err
      else callback null, clean _post

  getPosts: (callback)->
    Post.find().sort(updated_at: -1).all (err, posts) ->
      if err then callback err
      else callback null, clean posts

  getPostsBySlug: (slug, callback)->
    if _(slug).isArray() then [slug] = slug
    Post.first {slug}, (err, post) ->
      if err then callback err
      else
        callback null, clean post
