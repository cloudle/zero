gulp = require 'gulp'
concat = require 'gulp-concat'
rename = require 'gulp-rename'
merge = require 'merge-stream'

stylus = require 'gulp-stylus'
nib = require 'nib'
jeet = require 'jeet'
autoprefixer = require 'autoprefixer-stylus'
minifyCss = require 'gulp-minify-css'

coffee = require 'gulp-coffee'
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
    .pipe(sourcemaps.write())
    .pipe(concat('bundle.css'))
    .pipe(gulp.dest('./build/assets'))
    .pipe(minifyCss()).pipe(rename('bundle.min.css'))
    .pipe(gulp.dest('./build/assets'))

gulp.task 'script-bundle', ->
  gulp.src('./app/**/*.coffee')
  .pipe(sourcemaps.init())
  .pipe(coffee())
  .pipe(amdOptimize("main"))
  .pipe(sourcemaps.write())
  .pipe(concat("bundle.js"))
  .pipe(gulp.dest('./build/assets'))

gulp.task 'browser-sync', ['nodemon'], ->
  browserSync.init null,
    port: 2015
    proxy: "http://localhost:7000"
    files: ["./build/**/*.*", "./app/**/*.jade"]
    open: false

  gulp.watch "./app/**/*.styl", ['style-bundle']
  gulp.watch "./app/**/*.coffee", ['script-bundle']

gulp.task 'nodemon', (callback) ->
  started = false

  nodemon
    script: 'app.js'
    ignore: ['./node_modules/**']
  .on 'start', -> (callback(); started = true) unless started

gulp.task 'default', ['style-bundle','script-bundle', 'browser-sync']