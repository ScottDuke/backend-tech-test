class Song < ApplicationRecord
  belongs_to :artist
  belongs_to :city
  scope :find_by_title, ->(song_title) { includes(:artist, :city).where(title: song_title) }
end
