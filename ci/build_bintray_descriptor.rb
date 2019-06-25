#!/usr/bin/env ruby

require "json"

descriptor = {
  package: {
    name: ENV["BINTRAY_PACKAGE"],
    repo: ENV["BINTRAY_REPO"],
    subject: ENV["BINTRAY_SUBJECT"],
  },

  version: {
    name: ENV["BOTTLE_VERSION"],
    gpgSign: false,
  },

  files: [
    {
      includePattern: ENV["BOTTLE_LOCAL_FILENAME"],
      uploadPattern: ENV["BOTTLE_FILENAME"],
    },
  ],

  publish: true
}

JSON.dump(descriptor, File.open("bintray_descriptor.json", "w"))
