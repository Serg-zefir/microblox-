clrs = require 'colors'
del = require 'del'
gulp = require 'gulp'
pl = require('gulp-load-plugins')()

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

gulp.task 'clean', ->
  del kuda.out.base
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
  .pipe pl.coffeelint max_line_length: level: 'ignore'
  .pipe pl.coffeelint.reporter()
  .pipe pl.coffee()
  #.pipe pl.uglify()
  .pipe gulp.dest kuda.out.js
  .on 'end', ->
    console.log 'Client JS build!'.bold.cyan

gulp.task 'jd:part', ->
  gulp.src kuda.in.jdpart
  .pipe pl.plumber()
  .pipe pl.jade jdCmplOpt
  .pipe pl.angularTemplatecache
    module: 'partials'
    standalone: yes
    root: 'client'
  .pipe gulp.dest kuda.out.js

gulp.task 'jade', ['jd:part'], ->
  gulp.src kuda.in.jd
  .pipe pl.plumber()
  .pipe pl.jade jdCmplOpt
  # .pipe pl.angularTemplatecache
  #   module: 'templates'
  #   standalone: yes
  #   root: 'client'
  .pipe gulp.dest kuda.out.pub
  .on 'end', ->
    console.log 'Client HTML transform!'.bold.blue

gulp.task 'build', ['clean'], ->
  gulp.start 'server'
  gulp.start 'client'
  gulp.start 'jade'

# gulp.task 'files:watch', ->
#   pl.watch [
#     'index.jade'
#     'src/**/*.jade'
#     'src/**/*.coffee'
#     'src/**/*.less'
#   ], ->
#     gulp.start 'web:reload'

# gulp.task 'web:reload', [
#     'index:jade', 'src:coffee', 'src:less', 'src:jade:ng'
#     ], ->
#   gulp.src ''
#   .pipe pl.connect.reload()

# gulp.task 'src:jade:ng', ->
#   gulp.src 'src/**/*.jade'
#   .pipe pl.jade jadeCompilerOptions
#   .on 'error', ->
#     console.log 'Jade Compiler Error'.bold.red
#     this.emit 'end'
#   .pipe pl.angularTemplatecache
#     module: 'templates'
#     standalone: yes
#     root: 'src'
#   .pipe gulp.dest 'dict/scripts'

# gulp.task 'src:less', ->
#   gulp.src 'src/**/*.less'
#   .pipe pl.changed 'src', extension: '.css'
#   .pipe pl.sourcemaps.init()
#   .pipe pl.less()
#   .on 'error', ->
#     console.log 'Less Compiler Error'.bold.red
#     this.emit 'end'
#   .pipe pl.sourcemaps.write()
#   .pipe gulp.dest 'dict/styles'

# gulp.task 'src:coffee', ->
#   gulp.src 'src/**/*.coffee'
#   .pipe pl.changed 'src', extension: '.js'
#   .pipe pl.sourcemaps.init()
#   .pipe pl.coffeelint max_line_length: level: 'ignore'
#   .pipe pl.coffeelint.reporter()
#   .pipe pl.coffee()
#   .on 'error', -> this.emit 'end'
#   .pipe pl.sourcemaps.write()
#   .pipe gulp.dest 'dict/scripts'

# gulp.task 'index:jade', ['src:coffee', 'src:less', 'src:jade:ng'], ->
#   bowerFiles = require('wiredep')(directory: 'bower_components')

#   gulp.src 'index.jade'
#   .pipe pl.jade jadeCompilerOptions
#   .on 'error', ->
#     console.log 'Jade Compiler Error'.bold.red
#     this.emit 'end'
#   .pipe pl.inject(
#     gulp.src(bowerFiles.js, read: no)
#     name: 'bowerScripts'
#   )
#   .pipe pl.inject(
#     gulp.src(bowerFiles.css, read: no)
#     name: 'bowerStyles'
#   )
#   .pipe pl.inject(
#     gulp.src('dict/scripts/**/*.js', read: yes).pipe pl.angularFilesort()
#     name: 'ownScripts'
#   )
#   .pipe pl.inject(
#     gulp.src('dict/styles/**/*.css', read: no)
#     name: 'ownStyles'
#   )
#   .pipe gulp.dest ''

# gulp.task 'dev', ->
#   gulp.start 'server:start'
#   gulp.start 'files:watch'
#   gulp.start 'web:reload'

# gulp.task 'deploy', ->
#   gulp.start 'web:reload'

# gulp.task 'clean', (callback) ->
#   del [
#     '*.html'
#     'dict/**/*'
#   ], callback

# gulp.task 'default', -> gulp.start 'dev'
gulp.task 'default', ->
  console.log 'Gulp works!'.bold.red