handleify = require 'handleify'
coffeeify = require 'coffeeify'
shim = require 'browserify-shim'
uglify = require 'uglify-js2'

module.exports = (grunt)->

  beforeHook = (bundle)->
    bundle.transform coffeeify
    bundle.transform handleify
    shim bundle,
      zepto: path: './vendor/zepto', exports: 'Zepto'

  @initConfig
    clean:
      build: ['public/application.js']
    browserify2:
      serve:
        entry: './src/bootstrap.coffee'
        mount: '/application.js'
        server: './server.coffee'
        debug: yes
        beforeHook: beforeHook
      dev:
        entry: './src/bootstrap.coffee'
        mount: '/application.js'
        compile: './public/application.js'
        debug: yes
        beforeHook: beforeHook
      build:
        debug: no
        entry: './src/bootstrap.coffee'
        compile: './public/application.js'
        beforeHook: beforeHook
        afterHook: (src)->
          result = uglify.minify src, fromString: true
          result.code
    stylus:
      dev:
        options:
          debug: yes
          use: ['nib']
          import: ['nib']
        files:
          'public/style.css': 'stylesheets/**/*.styl'
      build:
        options:
          debug: no
          use: ['nib']
          import: ['nib']
        files:
          'public/style.css': 'stylesheets/**/*.styl'

  @loadNpmTasks 'grunt-contrib-clean'
  @loadNpmTasks 'grunt-browserify2'
  @loadNpmTasks 'grunt-devtools'
  @loadNpmTasks 'grunt-contrib-stylus'
  @loadNpmTasks 'grunt-contrib-watch'

  @registerTask 'default', ['clean:build', 'stylus:dev', 'browserify2:serve']
  @registerTask 'build', ['clean', 'browserify2:build', 'stylus:build']
  @registerTask 'serve', ['browserify2:serve']
  @registerTask 'dev', ['browserify2:dev', 'stylus:dev']
