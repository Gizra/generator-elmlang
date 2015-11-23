[![Build Status](https://travis-ci.org/<%= githubRepo %>.svg?branch=master)](https://travis-ci.org/<%= githubRepo %>)


> <%= projectName %>

## Installation

Make sure the following are installed:

* NodeJs (and npm)
* Elm (`npm install -g elm@0.15.1`)
* Compass (for SASS) (`gem update --system && gem install compass`)

## Usage

1. Serve locally, and watch file changes:

`gulp`

2. Prepare file for publishing (e.g. minify, and rev file names):

`gulp publish`

3. Deploy to GitHub's pages (`gh-pages` branch of your repository):

`gulp deploy`

## Unit Tests

In order to view the tests on the browser Start elm reactor (elm-reactor) and navigate to http://0.0.0.0:8000/src/elm/TestRunner.elm


## License

MIT
