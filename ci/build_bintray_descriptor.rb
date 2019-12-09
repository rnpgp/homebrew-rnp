#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

descriptor = {
  package: {
    name: ENV['BINTRAY_PACKAGE'],
    repo: ENV['BINTRAY_REPO'],
    subject: ENV['BINTRAY_SUBJECT']
  },

  version: {
    name: ENV['BOTTLE_VERSION'],
    gpgSign: false
  },

  files: [
    {
      includePattern: ENV['BOTTLE_LOCAL_FILENAME'],
      uploadPattern: ENV['BOTTLE_FILENAME']
    },
  ],

  publish: true
}

JSON.dump(descriptor, File.open(ENV['BINTRAY_DESCRIPTOR_FILENAME'], 'w'))
