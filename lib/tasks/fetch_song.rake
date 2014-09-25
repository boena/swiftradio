require 'net/http'
require 'json'

task :fetch_song do
  p 'Running fetch song job...'

  response = Net::HTTP.get_response(URI.parse('http://api.sr.se/api/v2/playlists/rightnow/?channelid=1607&format=json'))
  body = response.body
  data = JSON.parse body

  current_song = {
    "title" => data["playlist"]["song"]["title"],
    "artist" => data["playlist"]["song"]["artist"]
  }

  file = nil

  begin
    file = File.read('./songs.json')
  rescue Errno::ENOENT
    file = "{\"songs\": []}"
  end

  json = JSON.parse(file)

  if json["songs"].length > 0
    last_song = json["songs"][json["songs"].length - 1]

    unless last_song["title"].eql?(current_song["title"])
      json["songs"] << current_song

      File.open("./songs.json","w") do |f|
        f.write(json.to_json)
      end
    end
  else # First song
    json["songs"] << current_song

    File.open("./songs.json","w") do |f|
      f.write(json.to_json)
    end
  end
end
