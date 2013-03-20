handleify = require 'handleify'
coffeeify = require 'coffeeify'

module.exports = (grunt)->

  beforeHook = (bundle)->
    bundle.transform coffeeify
    bundle.transform handleify

  @initConfig
    clean:
      build: ['public/application.js']
      docs: ['public/docs']
    dss:
      docs:
        options:
          template: './dss/'
        files:
          'public/docs/': 'stylesheets/**/*.styl'
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
    stylus:
      dev:
        debug: yes
        files:
          'public/style.css': 'stylesheets/**/*.styl'
      build:
        files:
          'public/style.css': 'stylesheets/**/*.styl'

  @loadNpmTasks 'grunt-contrib-clean'
  @loadNpmTasks 'grunt-browserify2'
  @loadNpmTasks 'grunt-devtools'
  @loadNpmTasks 'grunt-contrib-stylus'
  @loadNpmTasks 'grunt-dss'

  @registerTask 'default', ['clean:build', 'stylus:dev', 'browserify2:dev']
  @registerTask 'build', ['clean', 'dss', 'browserify2:build']
  @registerTask 'docs', ['clean:docs', 'dss']
