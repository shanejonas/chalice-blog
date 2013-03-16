API = require '../../api'
PageModel = require './pagemodel'

PageModel::sync = (method, model, options)->
  switch method
    when "read"
      resp = API.getPostBySlug @get('slug'), (err, resp)->
        options.success model, resp, options
