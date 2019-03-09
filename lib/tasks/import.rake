class ImportHelper
  require 'open-uri'
  require 'json'

  def self.get_video_data(url)
    JSON.load(open(url))
  end
end

namespace :import do

  desc "import video data"
  task :video_data => :environment do
    videos = ImportHelper.get_video_data("https://s3-eu-west-1.amazonaws.com/sofar-eu-1/video_data.json")
    videos.each do |video|
      video_uid = video["video_uid"]
      song = video["song"]
      artist = Artist.find_or_create_by(song["artist"])
    end
  end

end