require 'sinatra/base'
require "sinatra/json"


class SwiftApp < Sinatra::Base
  helpers Sinatra::JSON

  get '/' do
    file = File.read('./songs.json', encoding: 'utf-8')
    json_file = JSON.parse(file)

    content_type 'application/json', :charset => 'utf-8'
    json_file.to_json
  end

end
