class BatchController < ApplicationController
  def create
    @results = []
    multi_photo_params = params.fetch(:photos)
    multi_photo_params.each do | single_photo_params |
      photo = Photo.new(single_photo_params.permit(:name, :description, :url, :taken_at, :album_id))
      if photo.save
        @results << {
          result: 'success',
          photo: photo
        }
      else
        @results << {
          result: 'error',
          errors: photo.errors
        }
      end
    end
    render json: @results, status: :multi_status
  end
end
