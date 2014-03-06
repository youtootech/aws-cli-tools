#!/usr/bin/env ruby

require 'thor'
require 'highline/import'

module AWSCLITools

  class CLI < Thor

    desc "backup_mysql", "Backup MySQL server to S3"
    def backup_mysql
      #
    end

  end

end