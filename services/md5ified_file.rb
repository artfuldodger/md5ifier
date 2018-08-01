require 'digest'
require 'csv'

class Md5ifiedFile
  def initialize(temp_file)
    self.temp_file = temp_file
  end

  def csv
    CSV.generate do |csv|
      strings_with_md5s.each do |string_with_md5|
        csv << [string_with_md5.sanitized_string, string_with_md5.md5]
      end
    end
  end

  private

  attr_accessor :temp_file

  def strings_with_md5s
    strings.map do |string|
      StringWithMd5.new(string)
    end
  end

  def strings
    temp_file.read.split("\n")
  end

  class StringWithMd5
    def initialize(string)
      self.string = string
    end

    def sanitized_string
      @sanitized_string ||= string.strip
    end

    def md5
      Digest::MD5.hexdigest(sanitized_string)
    end

    private

    attr_accessor :string
  end
end
