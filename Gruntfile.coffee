
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

	grunt.registerTask "clean-all", [
		"clean"
	]

	grunt.registerTask "build", [
		"clean"
		"sass"
	]

	grunt.registerTask "default", ["build"]
