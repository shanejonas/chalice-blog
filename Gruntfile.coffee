handleify = require 'handleify'
coffeeify = require 'coffeeify'

module.exports = (grunt)->

  beforeHook = (bundle)->
    bundle.transform coffeeify
    bundle.transform handleify

  @initConfig
    clean:
      build: ['public/application.js', 'public/docs/']
    DSS:
      docs:
        files:
          'public/docs/': 'public/style.css'
    browserify2:
      dev:
        entry: './src/bootstrap.coffee'
        mount: '/application.js'
        server: './server.coffee'
        debug: yes
        beforeHook: beforeHook
      build:
        entry: './src/bootstrap.coffee'
        compile: './public/application.js'
        beforeHook: beforeHook

  @loadNpmTasks 'grunt-contrib-clean'
  @loadNpmTasks 'grunt-browserify2'
  @loadNpmTasks 'DSS'

  @registerTask 'default', ['clean', 'browserify2:dev']
  @registerTask 'build', ['clean', 'DSS', 'browserify2:build']
