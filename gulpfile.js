var gulp = require('gulp');
var sass = require('gulp-sass');

var config = {
    assets_dir: './apps/web/assets',
    bootstrap_dir: './bower_components/bootstrap',
    jquery_dir: './bower_components/jquery',
    font_awesome_dir: './bower_components/font-awesome',
    react_dir: './bower_components/react',
    public_dir: './public/assets'
};

gulp.task('css', function(){
    return gulp.src(config.assets_dir + '/stylesheets/app.scss')
        .pipe(sass({
            includePaths: [
                config.bootstrap_dir  + '/scss',
                config.assets_dir + '/stylesheets/components',
                config.font_awesome_dir + '/scss'
            ]
        }))
        .pipe(gulp.dest(config.public_dir + '/stylesheets/'));
});

gulp.task('js', function(){
    return gulp.src(config.jquery_dir + '/dist/jquery.min.js')
            .pipe(gulp.dest(config.public_dir + '/javascript'))
        && gulp.src(config.react_dir + '/react.min.js')
            .pipe(gulp.dest(config.public_dir + '/javascript'))
        && gulp.src(config.react_dir + '/react-dom.min.js')
            .pipe(gulp.dest(config.public_dir + '/javascript'));
});

gulp.task('icons', function(){
    return gulp.src(config.font_awesome_dir + '/fonts/**.*')
        .pipe(gulp.dest(config.public_dir + '/fonts'));
});

gulp.task('default', ['css', 'js']);
gulp.task('full-build', ['css', 'js', 'icons']);