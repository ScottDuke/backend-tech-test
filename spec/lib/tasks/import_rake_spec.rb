require 'spec_helper'
require 'rake'

describe 'import rake task' do
  before :all do
    Rake.application.rake_require "tasks/import"
    Rake::Task.define_task(:environment)
  end

  describe 'import:video_data' do
    before do
      allow(ImportHelper).to receive(:get_video_data).and_return("")
    end

    let :run_rake_task do
      Rake::Task["import:video_data"].reenable
      Rake.application.invoke_task "import:video_data"
    end

    it "calls ImportHelper.get_video_data with video data url" do
      expect(ImportHelper).to receive(:get_video_data).with("https://s3-eu-west-1.amazonaws.com/sofar-eu-1/video_data.json")
      run_rake_task
    end
  end
end