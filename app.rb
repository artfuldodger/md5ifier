require 'sinatra'
require_relative 'services/md5ified_file'

get '/' do
  erb :form
end

post '/' do
  filename = params[:file][:filename]
  file = params[:file][:tempfile]

  content_type 'application/csv'
  attachment "md5ified_#{filename}"
  Md5ifiedFile.new(file).csv
end
