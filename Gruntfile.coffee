
'use strict'
module.exports = (grunt) ->

	# Load grunt tasks automatically
	require('load-grunt-tasks')(grunt)

	# Time how long tasks take. Can help when optimizing build times
	require('time-grunt')(grunt)

	grunt.initConfig

		config:
			app: 'source'
			dist: 'dist'
			tmp: '.tmp'

	# Empties folders to start fresh
		clean:
			dist: 'dist'
			server: '.tmp'

	# Compiles Sass to CSS and generates necessary files if requested
		sass:
			options:
				trace: true
				lineNumbers: true
				style: 'compressed'
				loadPath: [
					'bower_components'
				]
			dist:
				files: [
					expand: true
					cwd: '<%= config.app %>/styles'
					src: ['styles.scss']
					dest: '<%= config.dist %>/styles'
					ext: '.css'
				]

	# Copies remaining files to places other tasks can use
		copy:
			dist:
				files: [
					expand: true
					dot: true
					cwd: '<%= config.app %>'
					dest: '<%= config.dist %>'
					src: [
						'*.{ico,png,txt}'
						'.htaccess'
						'images/{,*/}*.webp'
						'{,*/}*.html'
						'{,*/}*.shtml'
						'styles/fonts/{,*/}*.*'
					]
				,
					expand: true
					dot: true
					cwd: '.'
					src: ['bower_components/bootstrap-sass-official/assets/fonts/bootstrap/*.*']
					dest: '<%= config.dist %>'
				]

		uglify:
			build:
				src: [
					'bower_components/jquery/dist/jquery.js'
					'bower_components/bootstrap-sass-official/assets/javascripts/bootstrap.js'
				]
				dest: '<%= config.dist %>/scripts/scripts.min.js'

	grunt.registerTask "clean-all", [
		"clean"
	]

	grunt.registerTask "build", [
		"clean"
		"sass"
		"uglify"
		"copy"
	]

	grunt.registerTask "default", ["build"]
