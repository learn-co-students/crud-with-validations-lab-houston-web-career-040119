class Song < ApplicationRecord
    validates :title, presence: true
    validates :released, inclusion: { in: [true, false] }
validates :release_year, presence: true
# validates :release_year, length
validates :artist_name, presence: true
end
