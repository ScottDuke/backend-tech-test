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

    let :run_rake_task do
      Rake::Task["import:video_data"].reenable
      Rake.application.invoke_task "import:video_data"
    end

    before do
      allow(ImportHelper).to receive(:get_video_data).and_return(parsed_data)
    end

    it "calls ImportHelper.get_video_data with video data url" do
      expect(ImportHelper).to receive(:get_video_data).with("https://s3-eu-west-1.amazonaws.com/sofar-eu-1/video_data.json")
      run_rake_task
    end

    it "creates new or find new artist" do
      expect(Artist).to receive(:find_or_create_by).with(parsed_data.first["song"]["artist"]).and_return(nil)
      run_rake_task
    end

    it "creates new or find new city" do
      expect(City).to receive(:find_or_create_by).with(parsed_data.first["song"]["city"]).and_return(nil)
      run_rake_task
    end

     it "creates new or find new city" do
      expect(Song).to receive(:find_or_create_by).with(parsed_data.first["song"]).and_return(nil)
      run_rake_task
    end
  end
end