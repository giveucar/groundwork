module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    watch:
      jade:
        files: '**/*.jade'
        tasks: ['jade']
      compass:
        files: '**/groundwork.sass'
        tasks: ['compass', 'cssmin']
      coffee:
        files: '**/*.coffee'
        tasks: ['coffee', 'uglify']

    jade:
      build:
        options:
          pretty: true
        files: [
          expand: true
          cwd: 'src/jade'
          src: ['**/*.jade', '!template.jade']
          dest: 'docs'
          ext: '.html'
        ]

    compass:
      build:
        options:
          config: 'config.rb'
          trace: true

    autoprefixer:
      build:
        options:
          browsers: ['last 2 versions']
        files:
          'css/groundwork.css': ['css/groundwork.css']

    coffee:
      individual:
        expand: true
        cwd: 'src/coffee'
        src: [
          '**/*.coffee',
          '!groundwork.all.coffee'
        ]
        dest: 'js'
        ext: '.js'
      concatenated:
        options:
          join: false
        files:
          "js/groundwork.all.js": ["src/coffee/components/navigation.coffee"
#          , "src/coffee/plugins/*.coffee"
          ]

    uglify:
      options:
        compress: false
      minify:
        options:
          compress: false
        files:
          'js/groundwork.all.min.js': ['js/groundwork.all.js']

    cssmin:
      minify:
        expand: true
        cwd: 'css/'
        src: ['groundwork.css', '!*.min.css']
        dest: 'css/'
        ext: '.min.css'

  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-autoprefixer'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-uglify'

  grunt.registerTask 'default',           ['build']
  grunt.registerTask 'build',             [
    'compass',
    'autoprefixer',
    # 'coffee:concatenated',
    'cssmin',
    # 'uglify'
  ]
  grunt.registerTask 'docs',              ['jade']
