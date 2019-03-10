class VideosController < ApplicationController
  def search
    results = if params[:song_name]
      get_songs
    end
    
    render json: results, status: :ok
  end

  private

  def get_songs
    songs = Song.find_by_title(search_params[:song_name])
    songs.as_json(include: [:artist, :city])
  end
  
  def search_params
    params.permit(:song_name)
  end
end
