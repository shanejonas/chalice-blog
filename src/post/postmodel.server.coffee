PostModel = require './postmodel'

PostModel::sync = (method, model, options)->
  switch method
    when "create"
      API.createPost @toJSON(), (err, resp)->
        options.success model, resp, options
    when "read"
      resp = API.getPostsBySlug @get('slug'), (err, resp)->
        options.success model, resp, options
    when "update"
      resp = API.updatePost @get('slug'), @toJSON(), (err, resp)->
        options.success model, resp, options
    when "delete"
      resp = API.deletePost @get('slug'), (err, resp)->
        options.success model, resp, options
