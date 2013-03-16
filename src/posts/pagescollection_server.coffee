API = require '../../api'
PagesCollection = require './pagescollection.coffee'
PagesCollection::sync = (method, model, options)->
  switch method
    when "read"
      resp = API.getPages (err, resp)->
        options.success model, resp, options

