class IndexController < ApplicationController

  def index
    @items = Item.for_city(@city).limit(24)
    recent
    categories
    @special_vars[:body][:class] = '_index_page'
  end

  private

  def recent
    if current_user
      views = ItemView.recent_user(current_user)
    else
      views = ItemView.recent_session(session)
    end
    @recent = views.map(&:item)
  end

  def categories
    @categories = Cathegory.index
  end
end
