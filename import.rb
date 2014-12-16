#!/usr/bin/env ruby

$LOAD_PATH << "#{ENV['RUBY_HOME']}/github/"


require 'github'
require 'app_config'


github = Github.new AppConfig::GITHUB_USER, AppConfig::SECRETS[:github_password]
github.import
