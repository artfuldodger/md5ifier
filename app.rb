require 'sinatra'
require_relative 'services/md5ified_file'

get '/' do
  erb :form
end

post '/' do
  filename = params[:file][:filename]
  file = params[:file][:tempfile]
  new_file_path = Md5ifiedFile.new(file).new_file_path

  send_file("./tmp/#{filename}", disposition: 'attachment', filename: "md5ified_#{filename}")
end
