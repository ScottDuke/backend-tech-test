class Video < ApplicationRecord
  belongs_to :song, required: false
end
