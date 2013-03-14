path = require 'path'
handleify = require 'handleify'
coffeeify = require 'coffeeify'

module.exports = (grunt)->

  @initConfig
    clean:
      build: ['public/application.js']
    browserify2:
      dev:
        entry: './src/bootstrap.coffee'
        mount: '/application.js'
        server: './server.coffee'
        debug: yes
        beforeHook: (bundle)->
          bundle.transform coffeeify
          bundle.transform handleify
      build:
        entry: './src/bootstrap.coffee'
        beforeHook: (bundle)->
          bundle.transform coffeeify
          bundle.transform handleify
        compile: './public/application.js'

  @loadNpmTasks 'grunt-contrib-clean'
  @loadNpmTasks 'grunt-browserify2'

  @registerTask 'default', ['clean', 'browserify2:dev']
  @registerTask 'build', ['clean', 'browserify2:build']
