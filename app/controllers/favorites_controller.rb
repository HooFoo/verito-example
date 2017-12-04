class FavoritesController < ApplicationController
  def add
    begin
      fav = Favorite.find_or_create_by item: Item.find(params[:id]), user: current_user, session: session[:id] do
        @created = true
      end
      Rails.cache.delete cache_key
      render json: {favorite: fav.id, created: @created, message: I18n::t('messages.favorites.new')}
    rescue
      render json: {error: I18n::t('errors.messages.favorites.could_not_add')}, status: 422
    end
  end

  def remove
    Favorite.find_by(item: params[:id], user: current_user.id).destroy
    Rails.cache.delete cache_key
    render json: {id: params[:id], message: I18n::t('messages.favorites.destroy')}
  end

  def index
    if current_user
      @favs = Favorite.where(user:current_user)
    else
      @favs = Favorite.where(session:session.id)
    end
  end

  private

  def cache_key
    current_user ? "fav-counters/users/#{current_user.id}" : "fav-counters/users/#{session.id}"
  end
end
