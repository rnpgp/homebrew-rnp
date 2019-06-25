#!/bin/bash

export BOTTLE_VERSION=`cat *.bottle.json | jq --raw-output '.[].formula.pkg_version'`
export BOTTLE_FILENAME=`cat *.bottle.json | jq --raw-output '.[].bottle.tags[].filename'`
export BOTTLE_LOCAL_FILENAME=`cat *.bottle.json | jq --raw-output '.[].bottle.tags[].local_filename'`
export BOTTLE_SHA256=`cat *.bottle.json | jq --raw-output '.[].bottle.tags[].sha256'`
