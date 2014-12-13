#!/usr/bin/env ruby

$LOAD_PATH << '.'

require 'github'
require 'app_config'


github = Github.new AppConfig::GITHUB_USER, AppConfig::SECRETS[:github_password]
github.import
