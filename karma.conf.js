/*global module*/
// Karma configuration
// http://karma-runner.github.io/0.10/config/configuration-file.html

module.exports = function(config) {
  'use strict';

  config.set({
    // base path, that will be used to resolve files and exclude
    basePath: '',

    frameworks: ['jasmine'],

    // list of files / patterns to load in the browser
    files: [
      // Required libraries
      'ui/app/bower_components/angular/angular.js',
      'ui/app/bower_components/angular-cookies/angular-cookies.js',
      'ui/app/bower_components/angular-bootstrap/ui-bootstrap-tpls.js',
      'ui/app/bower_components/jquery/jquery.js',
      'ui/app/bower_components/angular-ui-router/release/angular-ui-router.js',
      'ui/app/bower_components/sinonjs/sinon.js',

      // App under test
      'ui/app/app.js',
      'ui/app/modules/common/common.js',
      'ui/app/modules/common/**/*.js',
      'ui/app/modules/auth/auth.js',
      'ui/app/modules/auth/**/*.js',
      'ui/app/modules/search/search.js',
      'ui/app/modules/search/**/*.js',
      'ui/app/components/components.js',
      'ui/app/components/navbar/*.js',

      // templates
      'ui/app/components/navbar/navbar.html',
      'ui/app/modules/**/*.html', 

      // Mocks
      'ui/app/bower_components/angular-mocks/angular-mocks.js',

      // Tests
      'ui/test/modules/common/**/*.js',
      'ui/test/modules/auth/**/*.js',
      'ui/test/modules/search/**/*.js',
      'ui/test/components/navbar/*.js'
    ],

    // generate js files from html templates
    preprocessors: {
      '**/*.html': 'html2js'
    },
    
    ngHtml2JsPreprocessor: {
    	stripPrefix : 'ui/app/',
    	moduleName : 'templates'
    },


    // list of files / patterns to exclude
    exclude: [],

    // web server port
    port: 15472,

    // level of logging
    // possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
    logLevel: config.LOG_INFO,


    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: false,


    // Start these browsers, currently available:
    // - Chrome
    // - ChromeCanary
    // - Firefox
    // - Opera
    // - Safari (only Mac)
    // - PhantomJS
    // - IE (only Windows)
    browsers: ['Chrome'],


    // Continuous Integration mode
    // if true, it capture browsers, run tests and exit
    singleRun: true
  });
};
