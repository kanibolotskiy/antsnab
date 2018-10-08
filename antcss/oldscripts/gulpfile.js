var gulp = require('gulp'),
	autoprefixer = require('gulp-autoprefixer'),
	browserSync = require('browser-sync').create(),
	concat = require('gulp-concat'),
	plumber = require('gulp-plumber'),
	sass = require('gulp-sass'),
	sourcemaps = require('gulp-sourcemaps'),
	uglify = require('gulp-uglify');

var cfg = {
	stylesPath: 'dev/styles',
	scriptsPath: 'dev/scripts',
    stylesDestPath: 'public_html/catalog/view/theme/app/css',
    scriptsDestPath: 'public_html/catalog/view/javascript/app',
};

/* ========================================================================= */

////////////
// STYLES //
////////////
gulp.task('stl', function () {
	return gulp.src(cfg.stylesPath + '/main.scss')
		.pipe(sourcemaps.init())
		.pipe(sass({
			outputStyle: 'compressed' // expanded, compressed
		}).on('error', sass.logError))
		.pipe(sourcemaps.write('maps'))
		.pipe(gulp.dest(cfg.stylesDestPath))
		.pipe(browserSync.stream({
			match: '**/*.css'
		}));
});

gulp.task('stl:p', function () {
	return gulp.src(cfg.stylesPath + '/main.scss')
		.pipe(sourcemaps.init())
		.pipe(sass({
			outputStyle: 'compressed' // expanded, compressed
		}).on('error', sass.logError))
		.pipe(autoprefixer({
			browsers: ['last 3 versions', 'ie >= 9', 'iOS >= 6', 'Android >= 4']
		}))
		.pipe(sourcemaps.write('maps'))
		.pipe(gulp.dest(cfg.stylesDestPath))
		.pipe(browserSync.stream({
			match: '**/*.css'
		}));
});

////////////
// SERVER //
////////////
gulp.task('bsr', function () {
	browserSync.reload();
});

gulp.task('bsi', function () {
	browserSync.init({
		server: 'dist'
	});
});

/////////////
// SCRIPTS //
/////////////
gulp.task('ugl', function () {
	return gulp.src([cfg.scriptsDestPat + '/common.js' ])
		.pipe(plumber({
			errorHandler: function (err) {
				console.log(err);
				this.emit('end');
			}
		}))
		.pipe(uglify())
		.pipe(gulp.dest(cfg.scriptsDestPath));
});

gulp.task('conc', function() {
	return gulp.src([
			cfg.scriptsPath + '/_first.js',
			cfg.scriptsPath + '/lib/*.js',
			cfg.scriptsPath + '/vendor/*.js',
			cfg.scriptsPath + '/_last.js'
		])
                .pipe(concat('common.js'))
		.pipe(gulp.dest(cfg.scriptsDestPath));
});

gulp.task('scr', function() {
	return gulp.src([
			cfg.scriptsPath + '/_first.js',
			cfg.scriptsPath + '/lib/*.js',
			cfg.scriptsPath + '/vendor/*.js',
			cfg.scriptsPath + '/_last.js'
		])
		.pipe(concat('common.js'))
		.pipe(plumber({
			errorHandler: function (err) {
				console.log(err);
				this.emit('end');
			}
		}))
		.pipe(uglify())
		.pipe(gulp.dest(cfg.scriptsDestPath));
});

///////////
// WATCH //
///////////
gulp.task('watch', function () {
	gulp.watch(cfg.stylesPath + '/**/*.scss', ['stl']);
	gulp.watch(cfg.scriptsPath + '/**/*.js', ['conc']);
	//gulp.watch(cfg.scriptsPath + '/**/*.js', ['conc', 'bsr']);
	//gulp.watch('dist/*.html', ['bsr']);
});

/* ========================================================================= */

gulp.task('default', ['bsi', 'watch']);
gulp.task('prod', ['scr', 'stl:p']);
