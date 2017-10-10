#!/bin/bash

set -e
set -x

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # directory that the script is stored in, see http://stackoverflow.com/q/59895/334862
echo Script is located at $SCRIPT_DIR

mkdir $1
cd $1
ember init

for addon in ember-font-awesome ember-cli-bootstrap-4 ember-truth-helpers ember-simple-auth torii ember-cli-favicon ember-cli-sass ember-local-storage ember-moment
do
    ember install ${addon}
done

npm install
bower install || echo Failed to run "bower install"

for route in application
do
    ember generate route $route
done

cp -v "${SCRIPT_DIR}/app.scss" app/styles/
cp -v "${SCRIPT_DIR}/favicon.png" public/
cp -v "${SCRIPT_DIR}/.ember-cli" .
