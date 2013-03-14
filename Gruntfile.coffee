path = require 'path'
handleify = require 'handleify'
coffeeify = require 'coffeeify'

module.exports = (grunt)->

  @initConfig
    clean:
      build: ['public/application.js']
    browserify2:
      entry: './src/bootstrap.coffee'
      mount: '/application.js'
      server: './server.coffee'
      beforeHook: (bundle)->
        bundle.transform coffeeify
        bundle.transform handleify
      # debug: yes
      # compile: './public/application.js'

  @loadNpmTasks 'grunt-contrib-coffee'
  @loadNpmTasks 'grunt-contrib-clean'
  @loadNpmTasks 'grunt-browserify2'

  @registerTask 'default', ['clean', 'browserify2']
