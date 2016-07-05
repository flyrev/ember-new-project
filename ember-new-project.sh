#!/bin/bash

set -e
set -x

ember new $1
cd $1
ember install ember-cli-template-lint
ember install ember-truth-helpers
