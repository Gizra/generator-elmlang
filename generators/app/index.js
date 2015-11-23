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

  addOptions: function() {
    // Try to get value from the CLI.
    this.option('project-name', {
      desc: 'The project name',
      type: String,
      required: 'false'
    });

    this.option('github-repo', {
      desc: 'the GitHub repository URL',
      type: String,
      required: 'false'
    });
  },

  askForGithubRepo: function () {
    if (this.options['github-repo']) {
      // Get the value from the CLI.
      this.githubRepo = this.options['github-repo'];
      this.log('Setting GitHub repository to: ' + this.githubRepo);
      return;
    }

    var done = this.async();

    var prompts = [{
      name: 'githubRepo',
      message: 'What is the GitHub repository URL?',
      default: ''
    }];

    this.prompt(prompts, function (props) {
      var baseUrl = 'https://github.com/';

      if (!!props.githubRepo && props.githubRepo.indexOf(baseUrl) == -1) {
        throw new Error('Github repository URL should start with ' + baseUrl);
      }

      this.githubRepo = props.githubRepo.replace(baseUrl, '').replace(/\/$/, '');
      console.log(this.githubRepo);
      done();
    }.bind(this));
  },

  askForProjectName: function () {
    if (!this.githubRepo) {
      var done = this.async();

      var prompts = [{
        name: 'projectName',
        message: 'What is the project machine name?',
        default: 'my-app'
      }];

      this.prompt(prompts, function (props) {
        this.projectName = props.projectName;

        done();
      }.bind(this));
    }
    else {
      // Get the project name from the GitHub project name.
      var splitString = this.githubRepo.split('/');
      if (splitString.length != 2) {
        throw new Error ('GitHub repo name is malformed.');
      }

      this.projectName = splitString[1];
    }

  },


  writing: {
    app: function () {
      this.fs.copy(
        this.templatePath('_elm-package.json'),
        this.destinationPath('elm-package.json')
      );
      this.fs.copy(
        this.templatePath('_gitignore'),
        this.destinationPath('.gitignore')
      );
      this.fs.copy(
        this.templatePath('_package.json'),
        this.destinationPath('package.json')
      );
      this.fs.copy(
        this.templatePath('_gulpfile.js'),
        this.destinationPath('gulpfile.js')
      );

      this.template('README.md', 'README.md');

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
