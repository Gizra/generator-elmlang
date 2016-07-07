'use strict';
var yeoman = require('yeoman-generator');
var chalk = require('chalk');
var childProcess = require('child_process');
var elmPackage = require('./templates/_elm-package.json');
var semver = require('semver');
var yosay = require('yosay');

var SEMVER_REGEX = /\d{1,2}\.\d{1,2}\.\d{1,2}/;

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

      this.template('_elm-package.json', 'elm-package.json');
      this.template('README.md', 'README.md');
      this.template('runTests.js', 'runTests.js');


      this.directory('src', 'src');
    }
  },

  validateEnv: function () {
    var done = this.async();
    childProcess.exec('elm', function (error, stdout, stderr) {
      if (error) {
        done(new Error('The elm command emitted an error when we tried to call it! Make sure the Elm Platform is installed and retry.'));
        return;
      }
      // Look for instances of a semver in the elm command output. If none exist, it may mean a new version of the Elm
      // Platform not accounted for at the time of writing.
      var elmSemverMatches = SEMVER_REGEX.exec(stdout);
      if (!elmSemverMatches) {
        done(new Error('We couldn\'t find a semver for the Elm Platform in elm command output. Your Elm Platform version may be unsupported.'));
        return;
      }
      // Get the minimum version and the earliest unsupported version semvers from the elm-package.json.
      // Note: This is sensitive to string formatting of the elm-version in elm-platform.json. but adheres to the standard.
      var versionRange = elmPackage['elm-version'].split('<');
      var minimumSemver = versionRange[0].trim();
      var unsupportedSemver = versionRange[versionRange.length - 1].trim();
      var installedSemver = elmSemverMatches[0];
      // Check that the installed version falls within the specified range.
      var isMinimumSatisfied = semver.satisfies(installedSemver, '>= ' + minimumSemver);
      var isMaximumSatisfied = semver.satisfies(installedSemver, '< ' + unsupportedSemver);
      if (!isMinimumSatisfied || !isMaximumSatisfied) {
        done(new Error('Unsupported Elm Platform version! Install Elm Platform ' + minimumSemver + ' (or later) and retry.'));
        return;
      }
      done();
    });
  },

  install: function () {
    if (this.options['skip-install']) {
      this.log('Skipped installation');
      return;
    }

    this.log('Install node modules');
    this.npmInstall(null);

    this.log('Install elm packages');
    this.spawnCommand('elm-package', ['install', '--yes']);
  }
});
