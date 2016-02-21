var gulp = require('gulp');
var clean = require('gulp-clean');
var sass = require('gulp-sass');

var config = {
    bootstrapDir: './bower_components/bootstrap',
    jqueryDir: './bower_components/jquery',
    tetherDir: './bower_components/tether',
    assetDir: './apps/web/assets/',
    sourceDir: './apps/web/sources/'
};

gulp.task('clean-css', function(){
   return gulp.src(config.assetDir + '/stylesheets/*.css', {read: false})
       .pipe(clean({force: true}));
});

gulp.task('css', function(){
   return gulp.src(config.sourceDir + '/stylesheets/*.css')
       .pipe(sass({ includePaths: [config.bootstrapDir + '/scss'] }))
       .pipe(gulp.dest(config.assetDir + '/stylesheets'));
});

gulp.task('clean-js', function(){
   return gulp.src(config.assetDir + '/javascripts/*js', {read: false})
       .pipe(clean({force: true}));
});

gulp.task('js', function(){
    return gulp.src(config.tetherDir + '/dist/js/*.min.js')
        .pipe(gulp.dest(config.assetDir + '/javascripts'))
        && gulp.src(config.bootstrapDir + '/dist/js/*.min.js')
            .pipe(gulp.dest(config.assetDir + '/javascripts'))
        && gulp.src(config.jqueryDir + '/dist/*.min.js')
            .pipe(gulp.dest(config.assetDir + '/javascripts'));
});

gulp.task('default', ['css', 'js']);
gulp.task('full-build', ['clean-css', 'clean-js', 'css', 'js']);