module.exports =
  appRoutePrefix: '/posts'
  navigationItems: [
      name: 'Home', url: '/'
    ,
      name: 'New', url: '/new'
    ,
    # linking to a post in navigation will automatically get filtered
      name: 'About', url: '/posts/about'
    ,
      name: 'Login', url: '/login'
  ]
