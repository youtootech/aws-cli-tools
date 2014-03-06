#!/usr/bin/env ruby

require_relative "helpers/aws_factory"
require_relative "helpers/conf"
require_relative "helpers/timestamp"
require_relative "helpers/compactor"

config = Conf.new

aws_factory = AWSFactory.new(config)

filename = Compactor.compact("#{config.hostname}_#{Timestamp::get}.sql")

filepath = Compactor.compact("#{config.mysql_dump_root}/#{filename}")

puts "Filename: #{filename}"
puts "Filepath: #{filepath}"

puts "Creating database backup with arguments '#{config.raw['Database']['backup_args']}'"

backup_command = "mysqldump --username=#{config.raw['Database']['user']} --password=#{config.raw['Database']['pass']} #{config.raw['Database']['backup_args']} > #{filepath}"

puts "Running backup command: #{backup_command}"

system(backup_command)

S3 = aws_factory.create_instance(:s3)

puts "S3 buckets"
S3.buckets.each do |bucket|
  puts bucket.name
end

db_backups_bucket = S3.buckets['youtoo-backups-database']
puts db_backups_bucket.inspect

puts "Uploading YAML config to S3"
obj = db_backups_bucket.objects[filename]
obj.write(Pathname.new(filepath))
puts "Upload of #{filename} complete"