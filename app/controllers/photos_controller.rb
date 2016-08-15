class PhotosController < ApplicationController
  def index
    @photos = Photo.all.page(params[:page] || 1)
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      render :show, status: :created, location: @photo
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update(photo_params)
      render json: :show, status: :ok, location: @photo
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    head :no_content
  end

private

  def photo_params
    params.permit(:name, :description, :url, :taken_at, :album_id)
  end
end
