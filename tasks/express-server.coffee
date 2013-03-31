#
# * grunt-express-server
# * https://github.com/ericclemmons/grunt-express-server
# *
# * Copyright (c) 2013 Eric Clemmons
# * Licensed under the MIT license.

#
path = require 'path'
server = null # Store server between live reloads to close/restart express
module.exports = (grunt) ->
  grunt.registerTask 'express-keepalive', 'keep an express server alive', ->
    done = @async()

  grunt.registerTask 'express-server', 'Start an express web server', ->
    done = @async()
    if server
      console.log 'Killing existing Express server'
      server.kill 'SIGTERM'
      server = null

    server = grunt.util.spawn
      cmd: 'coffee'
      args: [grunt.config.get('server.script')]
      fallback: ->
    # Prevent EADDRINUSE from breaking Grunt
    , (err, result, code) ->

    server.stdout.on 'data', ->
      done() if done
      done = null

    server.stdout.pipe process.stdout
    server.stderr.pipe process.stdout
