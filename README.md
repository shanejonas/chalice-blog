#### To Run:

You need `npm` and `node` installed first. After that you can run:
```
  npm install
  npm install -g grunt-cli
  grunt
  open http://localhost:3000
```

---

#### Grunt Commands
 - `grunt` - run the server on http://localhost:3000
 - `grunt default` - same as `grunt`
 - `grunt docs` - generate docs (currently from [DSS](http://github.com/darcyclarke/DSS)) `public/docs/*`
 - `grunt build` - make a static `public/application.js` and docs for production
 - `grunt clean` - clean all build directories
 - `grunt clean:docs` - clean only `public/docs/*`
 - `grunt clean:build` - clean only `public/application.js`
