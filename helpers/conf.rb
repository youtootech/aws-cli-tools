require 'yaml'

class Conf

  attr_accessor :mysql_dump_root, :hostname, :box_name_path, :config_path, :raw

  def initialize
    @box_name_path = File.expand_path("/home/ec2-user/.box-name")
    @config_path = File.expand_path("/home/ec2-user/youtoo_config/youtoo-config.yaml")
    @mysql_dump_root = File.expand_path("/home/ec2-user/backups")
    @hostname = ""
    @raw = {}

    load_config
    find_hostname
  end

  def load_config
    @raw = YAML.load_file(@config_path)
  end

  def find_hostname
    if FileTest.exists?(File.expand_path(@box_name_path))
      @hostname = File.read(@box_name_path)
    else
      @hostname = `hostname`
    end
  end

  def explain
    puts self.inspect
  end

end