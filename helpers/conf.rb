require 'yaml'

class Conf

  attr_accessor :mysql_dump_root, :hostname

  @box_name_path = "/home/ec2-user/.box-name"

  def self.init
    puts "Hostname is #{self.hostname}"
  end

  def self.read
    YAML.load_file(self.config_path)
  end

  def self.item(key)
    config = self.read
    config[key]
  end

  def self.explain
    puts self.read
  end

  def self.config_path
    # "/home/ec2-user/youtoo_config/youtoo-config.yaml"
    "/Users/pierce/YouToo/config/config/youtoo-config.yaml"
  end

  def self.mysql_dump_root
    "/home/ec2-user/backups"
  end

  def self.hostname
    if FileTest.exists?(File.expand_path(@box_name_path))
      return File.read(@box_name_path)
    else
      return `hostname`
    end
  end

end