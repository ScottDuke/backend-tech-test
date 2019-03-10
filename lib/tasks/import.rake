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
      if song
        artist = Artist.find_or_create_by(song["artist"])
        city = City.find_or_create_by(song["city"])
        song = Song.find_or_create_by(id: song["id"], artist_id: artist.id, title: song["title"], cached_slug: song["cached_slug"], city_id: city.id)
      end

      Video.create(song_id: song.try(:id), video_uid: video_uid)
    end
  end

end