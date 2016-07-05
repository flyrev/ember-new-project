#!/bin/bash

set -e
set -x

install_addon() {
    ember install $1
    git add .
    git commit -am "ember install ${addon}"
}

mkdir $1
cd $1
ember init

for addon in ember-cli-template-lint ember-truth-helpers
do
    install_addon ${addon}
done

npm install
bower install
