gulp = require 'gulp'
gutil = require 'gulp-util'
order = require 'gulp-order'
concat = require 'gulp-concat'
rename = require 'gulp-rename'
addsrc = require 'gulp-add-src'
merge = require 'merge-stream'

stylus = require 'gulp-stylus'
nib = require 'nib'
jeet = require 'jeet'
autoprefixer = require 'autoprefixer-stylus'
minifyCss = require 'gulp-minify-css'

webpack = require 'gulp-webpack'
coffee = require 'gulp-coffee'
cjsx = require 'gulp-cjsx'
amdOptimize = require 'amd-optimize'

jade = require 'gulp-jade'
nodemon = require 'gulp-nodemon'
prettify = require 'gulp-jsbeautifier'
sourcemaps = require 'gulp-sourcemaps'

browserSync = require('browser-sync').create()

gulp.task 'webpack', ->
  gulp.src('./app/main.coffee')
  .pipe(webpack({
      output: {filename: 'bundle.js'}
      resolveLoader:
        modulesDirectories: ['node_modules']
      resolve:
        extensions: ['', '.js', '.cjsx', '.coffee']
      module:
        loaders: [
          test: /\.cjsx$/, loaders: ['coffee', 'cjsx']
        ,
          test: /\.coffee$/, loader: 'coffee'
        ]
    }))
  .pipe(gulp.dest('./build/assets'))

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
      'scripts/**/sys-*.coffee'
      'scripts/core/**/*.coffee'
      'scripts/stores/actions/**/*.coffee'
      'scripts/stores/events/**/*.coffee'
      'scripts/stores/**/*.coffee'
    ]))
  .pipe(sourcemaps.init())
  .pipe(coffee())
  .pipe(concat("bundle.js"))
  .pipe(sourcemaps.write({sourceRoot: '/app'}))
  .pipe(gulp.dest('./build/assets'))

gulp.task 'react-bundle', ->
  gulp.src(['./app/*.cjsx', './app/components/**/*.cjsx', './server/routers/**/*.cjsx'])
    .pipe(sourcemaps.init())
    .pipe(cjsx({bare: true}))
    .pipe(sourcemaps.write())
    .pipe(concat("react-bundle.js"))
    .pipe(gulp.dest('./build/assets'))
    .pipe(addsrc('./server/react-common-head.js'))
    .pipe(addsrc.append('./server/react-common-foot.js'))
    .pipe(concat("react-bundle.js"))
    .pipe(gulp.dest('./server'))

gulp.task 'browser-sync', ['nodemon'], ->
  browserSync.init null,
    port: 2015
    proxy: "http://localhost:7000"
    files: ["./build/**/*.*", "./server/**/*.jade"]
    open: false

  gulp.watch "./app/**/*.styl", ['style-bundle']
  gulp.watch "./app/**/*.coffee", ['script-bundle']
  gulp.watch ["./app/**/*.cjsx", "./server/routers/**/*.cjsx"], ['react-bundle']

gulp.task 'nodemon', (callback) ->
  started = false

  nodemon
    script: 'app.js'
    ignore: ['./node_modules/**']
  .on 'start', -> (callback(); started = true) unless started

gulp.task 'default', ['style-bundle','script-bundle', 'react-bundle', 'browser-sync']