require 'rails_helper'
require 'rake'

describe 'import rake task' do
  before :all do
    Rake.application.rake_require "tasks/import"
    Rake::Task.define_task(:environment)
  end

  describe 'import:video_data' do
    let :example_data do
      [
        {
          "video_uid": "wWRIyRRyTCI", 
          "song": {
            "id": 3976, "artist_id": 2745, "title": "Brunch", "cached_slug": "brunch", "city_id": 58, 
            "artist": {
              "id": 2745, "title": "Xoe Wise", "cached_slug": "xoe-wise"
            }, 
            "city": {
              "id": 58, "title": "Chicago", "cached_slug": "chicago"
            }
          }
        }
      ].to_json
    end

    let(:parsed_data) { JSON.load(example_data) }
    let(:song) { double("Song", id: 3976) }

    let :run_rake_task do
      Rake::Task["import:video_data"].reenable
      Rake.application.invoke_task "import:video_data"
    end

    before do
      allow(ImportHelper).to receive(:get_video_data).and_return(parsed_data)
      allow(Song).to receive(:find_or_create_by).and_return(song)
    end

    it "calls ImportHelper.get_video_data with video data url" do
      expect(ImportHelper).to receive(:get_video_data).with("https://s3-eu-west-1.amazonaws.com/sofar-eu-1/video_data.json")
      run_rake_task
    end

    it "creates new or find new artist" do
      artist = double("Artist", id: 2745)
      expect(Artist).to receive(:find_or_create_by).with(parsed_data.first["song"]["artist"]).and_return(artist)
      run_rake_task
    end

    it "creates new or find new city" do
      city = double("City", id: 58)
      expect(City).to receive(:find_or_create_by).with(parsed_data.first["song"]["city"]).and_return(city)
      run_rake_task
    end

     it "creates new or find new song" do
      song = parsed_data.first["song"]
      expected_args = {id: song["id"], artist_id: song["artist_id"], title: song["title"], cached_slug: song["cached_slug"], city_id: song["city_id"]}
      expect(Song).to receive(:find_or_create_by).with(expected_args)
      run_rake_task
    end

    it "creates new or find new video" do
      expect(Video).to receive(:create).with(song_id: song.id, video_uid: parsed_data.first["video_uid"])
      run_rake_task
    end
  end
end