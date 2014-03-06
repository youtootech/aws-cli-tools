class Compactor

  def self.compact(str)
    str.gsub(/\s/, '')
  end

end