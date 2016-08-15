class Photo < ActiveRecord::Base
  belongs_to :album

  validates :name, presence: true
  validates :album, presence: true

  validates_each :url do |photo, attr, value|
    if value.blank? 
      photo.errors.add(attr, :blank)
    else
      extension = File.extname(URI(value).path)
      unless extension == '.jpg' or extension == '.jpeg'
        photo.errors.add(attr, 'File must be a JPEG')
      end
    end
  end
  validates_associated :album, 
    :message => "Maximum of #{Rails.configuration.max_album_size} photos allowed per album"

  after_save do | photo |
    photo.album.update_average_date
  end
end
