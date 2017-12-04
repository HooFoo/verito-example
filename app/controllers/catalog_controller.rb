class CatalogController < ApplicationController

  before_action :check_page

  def index
    @items = []
    @sorting_attrs = prepare_sort_options
    @categories = prepare_cat_options
    @base_props = prepare_base_props
    search = prepare_search_params
    @items = Item.filtered(search)
  end

  def item
    if params[:id]
      @item = Item.find params[:id]
      increment_view @item
    else
      @error = "Not found"
    end
  end

  def filtered
    search = prepare_search_params
    template('more_items') {
      @items = Item.filtered(search)
    }
  end


  def more_items
    filtered
  end

  def price
    item = Item.find(params[:id])
    user = current_user
    if user.present?
      value = Money.new(params[:price].to_f*100,@currency.code)
      price = item.prices.create(user: user, price_type: 'proposed', value: value )
      item.update(action: true)
      render json: {result: 'ok'}
    else
      render json: {result: 'errors', errors: ['need log_in']}, status: 422
    end
  end

  private

  def check_page
    @page = params[:page] || 1
  end

  def increment_view(item)
    if @item
      view = ItemView.where(item: item, user:current_user, session:session.id).first_or_create!
    end
  end

  def prepare_search_params
    search = {}
    if params[:city_id]
      search[:city] = params[:city_id]
    else
      search[:city] = 'all'
    end
    search[:query] = params[:query]
    search[:sort] = parse_sort_params
    if params[:price]
      prices = params[:price].split(',')
      search[:prices] = {
          low: prices[0],
          high: prices[1]
      }
    end
    search[:user] = params[:user_id]
    if params[:cat_id]
      cat = params[:cat_id].split(',').last
      search[:category] = cat
    end
    search[:properties] = properties_params if params[:properties]
    search[:page] = params[:page]
    search
  end

  def properties_params
    if params[:properties].instance_of? String
      props = JSON.parse params[:properties]
    else
      props = params[:properties]
    end
    p_opts = []
    if props.size > 0
      props.each do |prop|
        if prop[:id] && prop[:type] && prop[:value]
          p = {}
          p[:id] = prop[:id]
          p[:type] = prop[:type]
          p[:value] = prop[:value]
          p_opts << p
        end
      end
    end
    p_opts
  end

  def parse_sort_params
    if params[:sort]
      sort = params[:sort].split(' ')
      {
          type: sort[0],
          order: sort[1]
      }
    else
      nil
    end
  end

  def prepare_cat_options
    Cathegory.main
  end

  def prepare_sort_options
    options = []
    Item::SortTypes[:types].each do |type|
      text = I18n.t("catalog.filters.sort.types.#{type}")
      types = []
      Item::SortTypes[:order].each do |order|
        txt = text +  I18n.t("catalog.filters.sort.order.#{order}")
        types << [txt, "#{type} #{order}"]
      end
      options += types
    end
    options
  end

  def prepare_base_props
    base = Cathegory.where(parent_id: nil, show: false).to_a
    properties = base.map &:properties
    properties.inject ([]) { |i, r| r << i.to_a }
  end
end
