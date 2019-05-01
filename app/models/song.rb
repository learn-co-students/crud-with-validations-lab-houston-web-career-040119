require 'time'

class TitleUniquenessValidator < ActiveModel::Validator
  def validate(record)
    song = Song.find_by(title: record.title, artist_name: record.artist_name, release_year: record.release_year)
    if song && (song.id != record.id)
      record.errors.add :base, 'Title, artist name and release year cannot be simultaneously repeated.'
    end
  end
end

class ReleaseYearValidator < ActiveModel::Validator
  def validate(record)
    if (record.released == true) && ((record.release_year == nil)||(record.release_year==""))
      record.errors.add :base, 'Release year is required if song has been released.'
    end

    if record.release_year
      if record.release_year.to_i > Time.now.year
        record.errors.add :base, 'Release year must be in the past'
      end
    end
  end
end


class Song < ApplicationRecord
  validates :title, presence: true
  validates_with TitleUniquenessValidator
  validates :released, inclusion: { in: [true,false] }
  validates :artist_name, presence: true
  validates_with ReleaseYearValidator
end


