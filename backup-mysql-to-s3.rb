#!/usr/bin/env ruby

require_relative "helpers/conf"
require_relative "helpers/timestamp"
require_relative "helpers/compactor"

Conf::init

config = Conf::read

filename = Compactor.compact("#{Conf.mysql_dump_root}/#{Conf.hostname}_#{Timestamp::get}.sql")

puts "Filename: #{filename}"

# puts "access_key: #{config['AWS']['IAM']['access_key']}, secret_key: #{config['AWS']['IAM']['secret_key']}"