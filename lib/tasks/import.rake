require 'open-uri'
require 'json'

class ImportHelper
  def self.get_video_data(url)
    JSON.load(open(url))
  end
end

namespace :import do

  desc "import video data"
  task :video_data do
    videos = ImportHelper.get_video_data("https://s3-eu-west-1.amazonaws.com/sofar-eu-1/video_data.json")
  end

end