'use strict';
var yeoman = require('yeoman-generator');
var chalk = require('chalk');
var yosay = require('yosay');

module.exports = yeoman.generators.Base.extend({
  greet: function () {
    this.log(yosay(
      'Welcome to the shining ' + chalk.red('Elm') + ' generator!'
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

  // Proccess the given repo name.
  getGithubRepo : function(repoName) {
    if (!repoName) {
      return '';
    }
    var baseUrl = 'https://github.com/';

    if (repoName.indexOf(baseUrl) == -1) {
      throw new Error('Github repository URL should start with ' + baseUrl);
    }

    this.log(chalk.blue('************************************************************'));
    this.log(chalk.blue('Do not forget to enable Travis-CI via https://travis-ci.org/'));
    this.log(chalk.blue('************************************************************'));

    // Remove the base URL, and trailing slash.
    return repoName.replace(baseUrl, '').replace(/\/$/, '');
  },

  askForGithubRepo: function () {
    if (this.options['github-repo']) {
      // Get the value from the CLI.
      this.githubRepo = this.getGithubRepo(this.options['github-repo']);
      return;
    }

    var done = this.async();

    var prompts = [{
      name: 'githubRepo',
      message: 'What is the GitHub repository URL?',
      default: ''
    }];

    this.prompt(prompts, function (props) {
      this.githubRepo = this.getGithubRepo(props.githubRepo);
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

      this.fs.copy(
        this.templatePath('_travis.yml'),
        this.destinationPath('.travis.yml')
      );

      this.template('README.md', 'README.md');
      this.template('runTests.js', 'runTests.js');


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
