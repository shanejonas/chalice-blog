PostModel = require '../post/postmodel.coffee'
PostsCollection = require '../posts/postscollection.coffee'

class AdminPostsCollection extends PostsCollection

  url: "/api/posts/all"

module.exports = AdminPostsCollection
