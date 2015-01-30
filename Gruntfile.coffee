
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
			tmp: '.tmp'

	# Compiles Sass to CSS and generates necessary files if requested
		sass:
			options:
				trace: true
				lineNumbers: true
				style: 'uncompressed'
				loadPath: [
					'bower_components'
				]
			dist:
				files: [
					expand: true
					cwd: '<%= config.app %>/styles'
					src: ['styles.scss']
					dest: '<%= config.tmp %>/styles'
					ext: '.css'
				]

		cssmin:
			target:
				files:
					'<%= config.dist %>/styles/styles.min.css': [
						'<%= config.app %>/styles/fontello/css/*.*'
						'<%= config.tmp %>/styles/styles.css'
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
						'images/*.*'
						'{,*/}*.html'
						'{,*/}*.shtml'
						'styles/fonts/{,*/}*.*'
					]
				,
					expand: true
					dot: true
					flatten: true
					cwd: '.'
					src: ['bower_components/bootstrap-sass-official/assets/fonts/bootstrap/*.*']
					dest: '<%= config.dist %>/fonts/'
				,
					expand: true
					dot: true
					flatten: true
					cwd: '.'
					src: ['source/styles/fontello/fonts/*.*']
					dest: '<%= config.dist %>/fonts/'
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
		"cssmin"
	]

	grunt.registerTask "default", ["build"]
