module.exports =
  getPosts: ->
    [
        id: 1
        title: 'Post Title'
        body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent molestie lobortis purus, quis interdum arcu cursus nec. Pellentesque eget massa nisi. Nulla facilisi. Vestibulum bibendum convallis ligula ut mattis. Vestibulum sed metus tortor, ut malesuada tellus. Donec convallis turpis et mi dictum venenatis. Maecenas accumsan vestibulum erat, non hendrerit sem convallis ac.'
      ,
        id: 2
        title: 'Other Post Title'
        body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent molestie lobortis purus, quis interdum arcu cursus nec. Pellentesque eget massa nisi. Nulla facilisi. Vestibulum bibendum convallis ligula ut mattis. Vestibulum sed metus tortor, ut malesuada tellus. Donec convallis turpis et mi dictum venenatis. Maecenas accumsan vestibulum erat, non hendrerit sem convallis ac.'
      ,
        id: 3
        title: 'Other Post Title'
        body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent molestie lobortis purus, quis interdum arcu cursus nec. Pellentesque eget massa nisi. Nulla facilisi. Vestibulum bibendum convallis ligula ut mattis. Vestibulum sed metus tortor, ut malesuada tellus. Donec convallis turpis et mi dictum venenatis. Maecenas accumsan vestibulum erat, non hendrerit sem convallis ac.'
      ,
        id: 4
        title: 'Other Post Title'
        body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent molestie lobortis purus, quis interdum arcu cursus nec. Pellentesque eget massa nisi. Nulla facilisi. Vestibulum bibendum convallis ligula ut mattis. Vestibulum sed metus tortor, ut malesuada tellus. Donec convallis turpis et mi dictum venenatis. Maecenas accumsan vestibulum erat, non hendrerit sem convallis ac.'
      ,
        id: 5
        title: 'Other Post Title'
        body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent molestie lobortis purus, quis interdum arcu cursus nec. Pellentesque eget massa nisi. Nulla facilisi. Vestibulum bibendum convallis ligula ut mattis. Vestibulum sed metus tortor, ut malesuada tellus. Donec convallis turpis et mi dictum venenatis. Maecenas accumsan vestibulum erat, non hendrerit sem convallis ac.'
      ,
        id: 6
        title: 'Other Post Title'
        body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent molestie lobortis purus, quis interdum arcu cursus nec. Pellentesque eget massa nisi. Nulla facilisi. Vestibulum bibendum convallis ligula ut mattis. Vestibulum sed metus tortor, ut malesuada tellus. Donec convallis turpis et mi dictum venenatis. Maecenas accumsan vestibulum erat, non hendrerit sem convallis ac.'
      ,
        id: 7
        title: 'Other Post Title'
        body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent molestie lobortis purus, quis interdum arcu cursus nec. Pellentesque eget massa nisi. Nulla facilisi. Vestibulum bibendum convallis ligula ut mattis. Vestibulum sed metus tortor, ut malesuada tellus. Donec convallis turpis et mi dictum venenatis. Maecenas accumsan vestibulum erat, non hendrerit sem convallis ac.'
      ,
        id: 8
        title: 'Other Post Title'
        body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent molestie lobortis purus, quis interdum arcu cursus nec. Pellentesque eget massa nisi. Nulla facilisi. Vestibulum bibendum convallis ligula ut mattis. Vestibulum sed metus tortor, ut malesuada tellus. Donec convallis turpis et mi dictum venenatis. Maecenas accumsan vestibulum erat, non hendrerit sem convallis ac.'
      ,
        id: 9
        title: 'Other Post Title'
        body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent molestie lobortis purus, quis interdum arcu cursus nec. Pellentesque eget massa nisi. Nulla facilisi. Vestibulum bibendum convallis ligula ut mattis. Vestibulum sed metus tortor, ut malesuada tellus. Donec convallis turpis et mi dictum venenatis. Maecenas accumsan vestibulum erat, non hendrerit sem convallis ac.'
      ,
        id: 10
        title: 'Other Post Title'
        body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent molestie lobortis purus, quis interdum arcu cursus nec. Pellentesque eget massa nisi. Nulla facilisi. Vestibulum bibendum convallis ligula ut mattis. Vestibulum sed metus tortor, ut malesuada tellus. Donec convallis turpis et mi dictum venenatis. Maecenas accumsan vestibulum erat, non hendrerit sem convallis ac.'
    ]

  getPostsById: (id)->
    @getPosts()[id - 1]
