require 'aws-sdk'
require_relative "conf"

class AWSFactory

  def initialize(config)
    AWS.config({
      :access_key_id => config.raw['AWS']['access_key'],
      :secret_access_key => config.raw['AWS']['secret_key'],
      :region => 'us-east-1'
    })
  end

  def create_instance(type)
    case type
    when :s3
      return AWS::S3.new
    when :ec2
      return AWS::EC2.new
    when :glacier
      return AWS::Glacier.new
    else
      raise "Invalid service requested: #{type}"
    end
  end

end