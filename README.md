#### The Grunt Build System

- `grunt` - Alias for default watch/livereload task
- `grunt default` - Alias for "clean", "stylus:dev", "browserify2:dev", "express-server", "livereload-start", "regarde" tasks.
- `grunt build` - Alias for "clean", "browserify2:build", "stylus:build" tasks.
- `grunt serve` - Alias for "express-server", "express-keepalive" tasks.
- `grunt dev` - Alias for "browserify2:dev", "stylus:dev" tasks.
- `grunt clean` - Clean files and folders. *
- `grunt browserify2` - commonjs modules in the browser *
- `grunt devtools` - Runs a server for devtools
- `grunt stylus` - Compile Stylus files into CSS *
- `grunt livereload` - Inform the browser some files have changed
- `grunt livereload-start`  Setup livereload to alert your browser when a file has changed
- `grunt regardeReset` - Reset the initialized status .. For test purpose ONLY
- `grunt regarde` - Observe files on the filesystem
- `grunt express-keepalive` -  keep an express server alive
- `grunt express-server` -  Start an express web server
- `grunt devtools` - A GUI For grunt in chrome devtools

![grunt-devtools](http://cloud.shanejon.as/image/3s0l2X3J0I1f/Screen%20Shot%202013-03-31%20at%2011.00.08%20PM.png)

---

#### To Run:

You need `node` and `mongodb` installed (probably from `brew`) first. After that you can run:
```
  npm install
  npm install -g grunt-cli
  grunt
  open http://localhost:3000
```
