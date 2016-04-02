var gulp = require('gulp');
var clean = require('gulp-clean');
var sass = require('gulp-sass');
var babel = require('gulp-babel');

var config = {
    bootstrapDir: './bower_components/bootstrap',
    jqueryDir: './bower_components/jquery',
    tetherDir: './bower_components/tether',
    faDir: './bower_components/font-awesome',
    reactDir: './bower_components/react',
    assetDir: './apps/web/assets/',
    sourceDir: './apps/web/sources/'
};

gulp.task('clean-css', function(){
   return gulp.src(config.assetDir + '/stylesheets/*.css', {read: false})
       .pipe(clean({force: true}));
});

gulp.task('css', function(){
   return gulp.src(config.sourceDir + '/stylesheets/*.css')
       .pipe(sass({ includePaths: [config.bootstrapDir + '/scss', config.faDir + '/scss'] }))
       .pipe(gulp.dest(config.assetDir + '/stylesheets'));
});

gulp.task('clean-js', function(){
   return gulp.src(config.assetDir + '/javascripts/*js', {read: false})
       .pipe(clean({force: true}));
});

gulp.task('js', function(){
   return gulp.src(config.sourceDir + '/javascripts/*.js')
        .pipe(gulp.dest(config.assetDir + '/javascripts'))
       && gulp.src(config.sourceDir + '/javascripts/*.jsx')
        .pipe(babel())
        .pipe(gulp.dest(config.assetDir + '/javascripts'));
});

gulp.task('3rd-party', function(){
    return gulp.src(config.tetherDir + '/dist/js/*.min.js')
        .pipe(gulp.dest(config.assetDir + '/javascripts'))
        && gulp.src(config.bootstrapDir + '/dist/js/*.min.js')
            .pipe(gulp.dest(config.assetDir + '/javascripts'))
        && gulp.src(config.jqueryDir + '/dist/*.min.js')
            .pipe(gulp.dest(config.assetDir + '/javascripts'))
        && gulp.src(config.reactDir + '/react.js')
            .pipe(gulp.dest(config.assetDir + '/javascripts'))
        && gulp.src(config.reactDir + '/react-dom.js')
            .pipe(gulp.dest(config.assetDir + '/javascripts'))
        && gulp.src(config.faDir + '/fonts/**.*')
            .pipe(gulp.dest(config.assetDir + '/fonts'));
});

gulp.task('icons', function(){
   return gulp.src(config.faDir + '/fonts/**.*')
       .pipe(gulp.dest(config.assetDir + '/fonts'));
});

gulp.task('watch-files', function(){
    gulp.watch(config.sourceDir + '/stylesheets/**.*css', ['css']);
    gulp.watch(config.sourceDir + '/javascripts/**.js*', ['js']);
});


gulp.task('default', ['css', 'js']);
gulp.task('watch', ['watch-files']);
gulp.task('full-build', ['clean-css', 'clean-js', 'css', '3rd-party', 'js', 'icons']);