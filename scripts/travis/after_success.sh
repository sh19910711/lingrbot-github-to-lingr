#!/bin/bash

if [[ "${TRAVIS_PULL_REQUEST}" == false ]] && [[ "${TRAVIS_BRANCH}" == "heroku/production" || "${TRAVIS_BRANCH}" == "heroku/development" ]]; then
  wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
  export HEROKU_APP_ID=$1
  echo APP = ${HEROKU_APP_ID}
  echo rev = `git rev-parse ${TRAVIS_BRANCH}`
  git remote add heroku git@heroku.com:${HEROKU_APP_ID}.git
  echo "Host heroku.com" >> ~/.ssh/config
  echo "   StrictHostKeyChecking no" >> ~/.ssh/config
  echo "   CheckHostIP no" >> ~/.ssh/config
  echo "   UserKnownHostsFile=/dev/null" >> ~/.ssh/config
  heroku config:set GITHUB_TO_LINGR_VERSION=${TRAVIS_COMMIT} --app ${HEROKU_APP_ID}
fi
