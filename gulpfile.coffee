gulp = require 'gulp'
gutil = require 'gulp-util'
order = require 'gulp-order'
concat = require 'gulp-concat'
rename = require 'gulp-rename'
merge = require 'merge-stream'

stylus = require 'gulp-stylus'
nib = require 'nib'
jeet = require 'jeet'
autoprefixer = require 'autoprefixer-stylus'
minifyCss = require 'gulp-minify-css'

coffee = require 'gulp-coffee'
cjsx = require 'gulp-cjsx'
amdOptimize = require 'amd-optimize'

jade = require 'gulp-jade'
nodemon = require 'gulp-nodemon'
prettify = require 'gulp-jsbeautifier'
sourcemaps = require 'gulp-sourcemaps'

browserSync = require('browser-sync').create()

gulp.task 'style-bundle', ->
  gulp.src('./app/**/*.styl')
    .pipe(sourcemaps.init())
    .pipe(stylus({use: [nib(), jeet(), autoprefixer()]}))
    .pipe(concat('bundle.css'))
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('./build/assets'))
#    .pipe(minifyCss()).pipe(rename('bundle.min.css'))
#    .pipe(gulp.dest('./build/assets'))

gulp.task 'script-bundle', ->
  gulp.src('./app/**/*.coffee')
  .pipe(order([
      '**/*super*.coffee'
    ]))
  .pipe(sourcemaps.init())
  .pipe(coffee({bare: true}))
  .pipe(concat("bundle.js"))
  .pipe(sourcemaps.write({sourceRoot: '/app'}))
  .pipe(gulp.dest('./build/assets'))

gulp.task 'react-bundle', ->
  gulp.src('./app/**/*.cjsx')
    .pipe(sourcemaps.init())
    .pipe(cjsx({bare: true}))
    .pipe(sourcemaps.write())
    .pipe(concat("react-bundle.js"))
    .pipe(gulp.dest('./build/assets'))

gulp.task 'browser-sync', ['nodemon'], ->
  browserSync.init null,
    port: 2015
    proxy: "http://localhost:7000"
    files: ["./build/**/*.*", "./app/**/*.jade"]
    open: false

  gulp.watch "./app/**/*.styl", ['style-bundle']
  gulp.watch "./app/**/*.coffee", ['script-bundle']
  gulp.watch "./app/**/*.cjsx", ['react-bundle']

gulp.task 'nodemon', (callback) ->
  started = false

  nodemon
    script: 'app.js'
    ignore: ['./node_modules/**']
  .on 'start', -> (callback(); started = true) unless started

gulp.task 'default', ['style-bundle','script-bundle', 'react-bundle', 'browser-sync']