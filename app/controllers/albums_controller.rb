require 'pp'

class AlbumsController < ApplicationController
  def index
    @albums = Album.all.page(params[:page] || 1)
  end

  def show
    @album = Album.includes(:photos).find(params[:id])
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      render json: :show, status: :created, location: @album
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      render json: :show, status: :ok, location: @album
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    head :no_content
  end

private

  def album_params
    params.permit(:name, :position)
  end
end
