# Basic-Auth config
#
config = require './config'

module.exports = (req, res, next)->
  header = req.headers['authorization'] or ''
  token = header.split(/\s+/).pop() or ''
  auth = new Buffer(token, 'base64').toString()
  [username, password] = auth.split(/:/)
  creds = {username, password}
  for account in config.accounts
    [user, pass] = account.split ':'
    if creds.username is user and creds.password is pass
      if req.url is '/api/login'
        res.send({logged_in: yes, username: user})
      else
        next()
    else
      res.send 401, 'Username and password do not match.'

