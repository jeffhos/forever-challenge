json.id album.id
json.name album.name
json.position album.position
json.average_date album.average_date
json.photo_count album.photos.count
if include_photos
  json.photos album.photos do | photo |
    json.partial! 'photos/photo', photo: photo
  end
end