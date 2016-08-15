class Album < ActiveRecord::Base
  has_many :photos

  validates :name, presence: true
  validates_each :photos do |album, attr, value|
    if album.photos.size >= Rails.configuration.max_album_size 
      album.errors.add attr, "Maximum of #{Rails.configuration.max_album_size} photos allowed per album"
    end
  end

  def update_average_date
    # Have to convert the taken_at column to seconds, because otherwise SQLite (or the Rail 
    # SQLite driver; not sure which) will just return the year
    self.average_date = Time.at(self.photos.average("strftime('%s',taken_at)")).utc.to_date
    self.save!
  end
end
