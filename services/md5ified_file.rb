require 'digest'

class Md5ifiedFile
  def initialize(temp_file)
    self.temp_file = temp_file
  end

  def new_file_path
    write_file
    path
  end

  private

  attr_accessor :temp_file

  def write_file
    File.open(path, 'w') do |f|
      f.write(new_file_contents)
    end
  end

  def path
    @path ||= "./tmp/#{SecureRandom.uuid}"
  end

  def new_file_contents
    strings_with_md5s.join("\n")
  end

  def strings_with_md5s
    strings.map do |string|
      StringWithMd5.new(string).to_s
    end
  end

  def strings
    temp_file.read.split("\n")
  end

  class StringWithMd5
    def initialize(string)
      self.string = string
    end

    def to_s
      [
        sanitized_string,
        md5
      ].join(',')
    end

    private

    attr_accessor :string

    def sanitized_string
      @sanitized_string ||= string.strip
    end

    def md5
      Digest::MD5.hexdigest(sanitized_string)
    end
  end
end
