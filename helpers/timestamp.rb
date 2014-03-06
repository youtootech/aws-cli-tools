class Timestamp

  def self.get(format = "%Y-%m-%d %H:%M:%S")
    time = Time.new
    time.strftime(format)
    return time
  end

end