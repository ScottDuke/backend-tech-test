require 'rails_helper'

RSpec.describe VideosController, type: :controller do
  describe "#search" do
    context "searching for songs" do
      let(:song_name) { "some song name" }
      let(:song_results) { [Song.new(id: 1, title: song_name, cached_slug: song_name)] }
      let(:search_params) { { song_name: song_name } }

      before do
        allow(controller).to receive(:get_songs).and_return(song_results)
      end

      it "returns a ok status code" do
        get :search, params: search_params
        expect(response).to have_http_status(200)
      end

      it "calls #get_songs" do
        expect(controller).to receive(:get_songs).and_return(song_results)
        get :search, params: search_params
      end

      it "returns song resutls" do
        get :search, params: search_params
        expect(response.body).to eql(song_results.to_json)
      end

    end
    
  end

end
