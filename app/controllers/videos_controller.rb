class VideosController < ApplicationController
  def search
    render json: filter_search, status: :ok
  end

  private

  def filter_search
    if params[:song_name]
      get_songs
    elsif params[:artist]
      get_artists
    elsif params[:city]
      get_cities
    else
      { search: "No search query" }
    end
  end

  def get_songs
    songs = Song.find_by_title(search_params[:song_name])
    songs.as_json(include: [:artist, :city])
  end

  def get_artists
    artists = Artist.find_by_title(search_params[:artist])
    artists.as_json(include: :songs)
  end

  def get_cities
    cities = City.find_by_title(search_params[:city])
    cities.as_json(include: { songs: {
      include: :artist
      }
    })
  end
  
  def search_params
    params.permit(:song_name, :artist, :city)
  end
end
