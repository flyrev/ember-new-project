#!/bin/bash

set -e
set -x

install_addon() {
    ember install $1
    git add .
    git commit -am "ember install ${addon}"
}

generate_route() {
    ember generate route $1
    git add .
    git commit -am "ember generate route ${route}"
}

mkdir $1
cd $1
ember init
git add .
git commit -am "Initial app"

for addon in ember-cli-template-lint ember-truth-helpers ember-simple-auth torii ember-cli-favicon
do
    install_addon ${addon}
done

npm install
bower install

for route in application
do
    generate_route $route
done

git push

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # directory that the script is stored in, see http://stackoverflow.com/q/59895/334862
cp -v "${SCRIPT_DIR}/favicon.png" "$1/public"

echo Sample favicon added (not commited)
