#!/bin/bash

set -e
set -x

mkdir $1
cd $1
ember init

for addon in ember-cli-template-lint ember-truth-helpers
do
    ember install ${addon}
    git add .
    git commit -am "ember install ${addon}"
done

npm install
bower install
