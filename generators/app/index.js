'use strict';
var yeoman = require('yeoman-generator');
var chalk = require('chalk');
var yosay = require('yosay');

module.exports = yeoman.generators.Base.extend({
  greet: function () {
    this.log(yosay(
      'Welcome to the shining ' + chalk.red('GeneratorElmlang') + ' generator!'
    ));
  },

  writing: {
    app: function () {
      this.fs.copy(
        this.templatePath('_elm-package.json'),
        this.destinationPath('elm-package.json')
      );
      this.fs.copy(
        this.templatePath('_package.json'),
        this.destinationPath('package.json')
      );
      this.fs.copy(
        this.templatePath('_gulpfile.js'),
        this.destinationPath('gulpfile.js')
      );

      this.directory('src', 'src');
    }
  },

  install: function () {
    if (this.options['skip-install']) {
      this.log('Skiped installation');
      return;
    }

    this.log('Install node modules');
    this.npmInstall(null);

    this.log('Install elm packages');
    this.spawnCommand('elm-package', ['install', '--yes']);
  }
});
