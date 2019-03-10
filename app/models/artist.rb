class Artist < ApplicationRecord
  has_many :songs

  scope :find_by_title, ->(title) { includes(:songs).where('lower(title) = lower(?)', title) }

end
