require 'sinatra/base'
require "sinatra/json"


class SwiftApp < Sinatra::Base
  helpers Sinatra::JSON

  get '/' do
    file = File.read('./songs.json')
    json_file = JSON.parse(file)
    json json_file
  end

end
