json.albums @albums do | album |
  json.partial! 'albums/album', album: album, include_photos: false
end
if @albums.current_page > 1
  json.prev url_for(page: @albums.current_page - 1)
end
if @albums.current_page < @albums.total_pages
  json.next url_for(page: @albums.current_page + 1)
end