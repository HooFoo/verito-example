class PhotosController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def new
    pp = photos_params
    photo = Photo.create! image: pp, photo_type: 'user'
    if session[:photos].blank?
      session[:photos] = [photo.id]
    else
      session[:photos] << photo.id
    end
    render json: {id: photo.id, photo: photo, url: photo.image.miniature.url}
  end

  def delete
    photo = Photo.find params[:id]
    if session[:photos]
      id = params[:id].to_i
      photo.destroy if session[:photos].include? id
      session[:photos].delete id
    end
    render json: { result: 'ok' }
  end

  private

  def photos_params
    params.require(:photo)
  end
end
