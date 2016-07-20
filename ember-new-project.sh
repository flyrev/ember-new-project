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

for addon in ember-cli-template-lint ember-truth-helpers ember-simple-auth torii ember-cli-favicon
do
    install_addon ${addon}
done

npm install
bower install

git add app
git commit -am "Initial app"

for route in application
do
    generate_route $route
done

git push

echo Add favicon to public/favicon.png
