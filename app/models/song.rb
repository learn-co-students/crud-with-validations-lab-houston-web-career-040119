class Song < ApplicationRecord
    validates :title, presence: true
    validates :title, uniqueness: true, if: :same_year?
    validates :released, inclusion: [true, false]
    validates :release_year, numericality: true, if: :has_released?
    validates :release_year, numericality: { less_than_or_equal_to: Time.new.year}, if: :has_released?

    def same_year?
        Song.find_by(title: title, artist_name: artist_name, release_year: release_year)
    end

    def has_released?
        released
    end
end
