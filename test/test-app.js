'use strict';

var path = require('path');
var assert = require('yeoman-generator').assert;
var helpers = require('yeoman-generator').test;
var os = require('os');

describe('generator elmlang:app', function () {
  before(function (done) {
    helpers.run(path.join(__dirname, '../generators/app'))
      .withOptions({ skipInstall: true })
      .withPrompts({ someOption: true })
      .on('end', done);
  });

  it('creates files', function () {
    assert.file([
      '.gitignore',
      '.travis.yml',
      'elm-package.json',
      'gulpfile.js',
      'package.json',
      'README.md',
      'runTests.js'
    ]);
  });

  it('adds the stylesheet link to index.html', function () {
    assert.fileContent('index.html', '<link rel="stylesheet" href="assets/stylesheets/style.css" />')
  });

});
