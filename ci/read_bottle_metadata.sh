#!/bin/bash

BOTTLE_VERSION=$(< ./*.bottle.json jq --raw-output '.[].formula.pkg_version')
BOTTLE_FILENAME=$(< ./*.bottle.json jq --raw-output '.[].bottle.tags[].filename')
BOTTLE_LOCAL_FILENAME=$(< ./*.bottle.json jq --raw-output '.[].bottle.tags[].local_filename')
BOTTLE_SHA256=$(< ./*.bottle.json jq --raw-output '.[].bottle.tags[].sha256')

export BOTTLE_VERSION="${BOTTLE_VERSION:?Missing BOTTLE_VERSION}"
export BOTTLE_FILENAME="${BOTTLE_FILENAME:?Missing BOTTLE_FILENAME}"
export BOTTLE_LOCAL_FILENAME="${BOTTLE_LOCAL_FILENAME:?Missing BOTTLE_LOCAL_FILENAME}"
export BOTTLE_SHA256="${BOTTLE_SHA256:?Missing BOTTLE_SHA256}"
