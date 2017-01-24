clrs = require 'colors'
del = require 'del'
gulp = require 'gulp'
pl = require('gulp-load-plugins')()

prod = off

jdCmplOpt =
  basedir: __dirname
  pretty: yes

kuda =
  in:
    jd: [
      'client/**/*.jade'
      '!**/layout.jade'
    ]
    jdpart: 'client/partials/**/*.jade'
    style: 'client/**/*.css'
    cofSer: [
      'server/**/*.coffee'
    ]
    cofClnt: [
      'client/**/*.coffee'
    ]
  out:
    base: 'web/'
    pub: 'web/public/'
    js: 'web/public/js/'
    css: 'web/public/css/'
  watch: 'client/**/*'

gulp.task 'clean', ->
  del kuda.out.base, {read: off}
  .then (paths) ->
    console.log 'Deleted files and folders:'.bold.yellow
    console.log clrs.bgMagenta paths.join '\n'

gulp.task 'server', ->
  gulp.src kuda.in.cofSer
  .pipe pl.plumber()
  .pipe pl.coffeelint max_line_length: level: 'ignore'
  .pipe pl.coffeelint.reporter()
  .pipe pl.coffee()
  .pipe pl.uglify()
  .pipe gulp.dest kuda.out.base
  .on 'end', ->
    console.log 'Server build!'.america.bold

gulp.task 'client', ->
  gulp.src kuda.in.cofClnt
  .pipe pl.plumber()
  .pipe pl.if !prod, pl.newer kuda.out.js
  .pipe pl.coffeelint max_line_length: level: 'ignore'
  .pipe pl.coffeelint.reporter()
  .pipe pl.coffee()
  #.pipe pl.uglify()
  .pipe gulp.dest kuda.out.js
  .on 'end', ->
    console.log 'Client JS build!'.bold.cyan


gulp.task 'jade', ->
  gulp.src kuda.in.jd
  .pipe pl.plumber()
  .pipe pl.if !prod, pl.newer kuda.out.pub
  .pipe pl.jade jdCmplOpt
  .pipe gulp.dest kuda.out.pub
  .on 'end', ->
    console.log 'Client HTML transform!'.bold.blue

gulp.task 'css', ->
  gulp.src kuda.in.style
  .pipe pl.plumber()
  .pipe pl.flatten { includeParents: 0 }
  .pipe pl.if !prod, pl.newer kuda.out.css
  .pipe gulp.dest kuda.out.css
  .on 'end', ->
    console.log 'Client CSS copy!'.bold.green

gulp.task 'build', ['clean'], ->
  prod = on
  gulp.start 'server'
  gulp.start 'client'
  gulp.start 'jade'
  gulp.start 'css'

gulp.task 'watch', ->
  gulp.watch kuda.watch, ['client', 'jade', 'css']
  .on "change", (e) ->
    console.log "Resource file " + e.path.replace(/^.*smile\//, '> ') +
      " has been changed. Updating.".bold.blue

gulp.task 'default', ['watch'], ->
  console.log 'Gulp works!'.bold.red

# gulp.task 'jd:part', ->
#   gulp.src kuda.in.jdpart
#   .pipe pl.plumber()
#   .pipe pl.if !prod, pl.newer kuda.out.js
#   .pipe pl.jade jdCmplOpt
#   .pipe pl.angularTemplatecache
#     module: 'partials'
#     standalone: yes
#     root: 'client'
#   .pipe gulp.dest kuda.out.js