class City < ApplicationRecord
  has_many :songs

  scope :find_by_title, ->(title) { includes(:songs).where(title: title) }
end
