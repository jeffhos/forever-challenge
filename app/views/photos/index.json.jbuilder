json.photos @photos do | photo |
  json.partial! 'photos/photo', photo: photo
end
if @photos.current_page > 1
  json.prev url_for(page: @photos.current_page - 1)
end
if @photos.current_page < @photos.total_pages
  json.next url_for(page: @photos.current_page + 1)
end