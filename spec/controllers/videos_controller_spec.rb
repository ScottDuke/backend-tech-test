require 'rails_helper'

RSpec.describe VideosController, type: :controller do
  describe "#search" do
    it "calls #filter_search" do
      expect(controller).to receive(:filter_search)
      get :search
    end

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

    context "when there is no search term" do
      before { get :search }
      
      it "returns a ok status code" do
        expect(response).to have_http_status(200)
      end

      it "returns a message that there was no search query" do
        expect(response.body).to match("No search query")
      end
      
    end
    
  end

end
