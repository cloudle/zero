var gulp = require('gulp'),
  order = require('gulp-order'),
  rename = require('gulp-rename'),
  merge = require('merge-stream'),
  gulpIf = require('gulp-if'),
  concat = require('gulp-concat'),
  addsrc = require('gulp-add-src'),
  stylus = require('gulp-stylus'),
  nib = require('nib'),
  jeet = require('jeet'),
  rupture = require('rupture'),
  autoprefixer = require('autoprefixer-stylus'),
  minifyCss = require('gulp-minify-css'),

  jade = require('gulp-jade'),
  coffee = require('gulp-coffee'),
  cjsx = require('gulp-cjsx'),
  react = require('gulp-react'),
  sourcemaps = require('gulp-sourcemaps'),

  nodemon = require('gulp-nodemon'),
  browserSync = require('browser-sync').create();

var paths = {
  styles: [
      './app/styles/main.styl',
      './app/styles/framework/**/*.styl',
      './app/styles/components/**/*.styl',
      './app/styles/app/**/*.styl'
  ],
  scripts: [
    './app/scripts/**/sys-*.coffee',
    './app/scripts/core/**/*.coffee',
    './app/scripts/stores/actions/**/*.coffee',
    './app/scripts/stores/events/**/*.coffee',
    './app/scripts/stores/**/*.coffee'
  ],
  reactTemplates: [
    './app/*.*jsx',
    './app/partials/**/*.*jsx',
    './app/components/**/*.*jsx',
    './server/routers/**/*.*jsx'
  ]
};

gulp.task('style-bundle', function() {
  gulp.src(paths.styles)
      .pipe(sourcemaps.init())
      .pipe(stylus(stylus({use: [nib(), jeet(), autoprefixer()]})))
      .pipe(concat("bundle.css"))
      .pipe(sourcemaps.write())
      .pipe(gulp.dest('./assets'))
});

gulp.task('script-bundle', function() {
  gulp.src(paths.scripts)
      .pipe(sourcemaps.init())
      .pipe(coffee())
      .pipe(concat("bundle.js"))
      .pipe(sourcemaps.write({sourceRoot: '/app'}))
      .pipe(gulp.dest('./assets'))
});

gulp.task('react-bundle', function() {
  gulp.src(paths.reactTemplates)
      .pipe(sourcemaps.init())
      .pipe(gulpIf(/[.]cjsx$/, cjsx(), react()))
      .pipe(sourcemaps.write())
      .pipe(concat("react-bundle.js"))
      .pipe(gulp.dest('./assets'))
      .pipe(addsrc('./server/react-common-head.js'))
      .pipe(addsrc.append('./server/react-common-foot.js'))
      .pipe(concat("react-bundle.js"))
      .pipe(gulp.dest('./server'))
});

gulp.task('browser-sync', ['nodemon'], function() {
  browserSync.init(null, {
    port: 2015,
    proxy: "http://localhost:7000",
    files: ["./assets/**/*.*", "./server/**/*.jade"],
    open: false
  });

  gulp.watch("./app/**/*.styl", ['style-bundle']);
  gulp.watch("./app/**/*.coffee", ['script-bundle']);
  gulp.watch(["./app/**/*.cjsx", "./server/routers/**/*.cjsx"], ['react-bundle']);
});

gulp.task('nodemon', function (callback) {
  var started = false;
  nodemon({script: 'app.js'}).on('start', function () {
    if (!started) {
      callback(); started = false;
    }
  });
});

gulp.task('default', ['style-bundle','script-bundle', 'react-bundle', 'browser-sync']);