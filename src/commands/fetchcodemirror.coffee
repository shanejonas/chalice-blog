Backbone = require 'backbone'
$ = Backbone.$

localCache = {}

# zepto getScript converted to coffeescript
# http://stackoverflow.com/questions/8556465/whats-the-zepto-equivalent-of-jquery-getscript
$.getScript = (url, success, error)->
  script = document.createElement("script")
  $script = ($ script)
  script.src = url
  ($ "head").append(script)
  $script.bind("load", success)
  $script.bind("error", error)

_ = require 'underscore'
files = [
  "/codemirror/continuelist.js"
  "/codemirror/vim.js"
  "/codemirror/markdown.js"
  "/codemirror/xml.js"
]

module.exports = (callback)->
  cb = _.after files.length, callback

  # load codemirror first
  $.getScript "/codemirror/codemirror.js", ->

    # load the rest
    for file in files
      $.getScript file, (data)->
         console.log(data)
         console.log('Load was performed.')
         cb?()
