# Basic-Auth config
#
config = require './config'

module.exports = (req, res, next)->
  header = req.headers['authorization'] or ''
  token = header.split(/\s+/).pop() or ''
  auth = new Buffer(token, 'base64').toString()
  parts = auth.split(/:/)
  creds =
    username: parts[0]
    password: parts[1]
  for account in config.accounts
    [username, password] = account.split ':'
    if creds.username is username and creds.password is password
      if req.url is '/api/login'
        res.send({logged_in: yes, username: username})
      else
        next()
    else
      res.send 401

