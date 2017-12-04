class PagesController < ApplicationController
  def show
    @page = TextPage.by_slug(params[:slug])
    if @page.instance_of? TextPage
      if @page.draft && @page.draft_key != params[:key]
        redirect_to '/403.html'
      end
    else
      redirect_to '/404.html'
    end
  end
end
