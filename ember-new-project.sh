#!/bin/bash

set -e
set -x


install_addon() {
    ember install $1
    (git add . && git commit -am "ember install ${addon}") || echo Not in a Git repository?
}

generate_route() {
    ember generate route $1
    git add . || echo Not in a Git repository?
    git commit -am "ember generate route ${route}" || echo Not in a Git repository?
}

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # directory that the script is stored in, see http://stackoverflow.com/q/59895/334862
echo Script is located at $SCRIPT_DIR

mkdir $1
cd $1
ember init

for addon in ember-cli-bootstrap-4 ember-truth-helpers ember-simple-auth torii ember-cli-favicon ember-cli-sass ember-local-storage ember-moment
do
    install_addon ${addon}
done

npm install
bower install || echo Failed to run "bower install"

for route in application
do
    generate_route $route
done

cp -v "${SCRIPT_DIR}/app.scss" app/styles/
cp -v "${SCRIPT_DIR}/favicon.png" public/

(git add . && git commit -am "Initial app") || echo Not in a Git repository?
