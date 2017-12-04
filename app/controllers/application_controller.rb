class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_user
  before_action :set_city
  before_action :set_lang
  before_action :set_counter
  after_action :save_audit_info, only: %i(create update destroy), if: Proc.new { request.path.split('/')[1] == 'admin' }
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :init_special_variables
  before_action :set_currency
  before_action :cities_list
  before_action :langs_list
  before_action :currencies_list
  before_action :favs_counter, unless: Proc.new { @user.nil? }
  before_action :analytics, if: Proc.new { request.format.html? }

  protected

  def configure_permitted_parameters
    added_attrs = [:mobile, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def template(name)
    if block_given?
      yield
    end
    render template: "templates/#{name}", layout: false
  end

  private

  def set_city
    if @user.nil?
      begin
        @city = City.find session[:city_id]
      rescue
        city = IpService.ip_city request.remote_ip
        begin
          @city = City.find_by_name! city
        rescue
          @city = City.default_city.first
        end
        session[:city_id] = @city.id
      end
    else
      @city = current_user.profile.city
    end
  end

  def set_currency
    if @user.nil?
      begin
        @currency = Currency.find session[:currency_id]
      rescue
        @currency = Currency.where(code: 'RUB').first
        session[:currency_id] = @currency.id
      end
    else
      @currency = current_user.profile.currency
    end
  end

  def set_user
    @user = current_user
  end

  def set_lang
    if @user.nil?
      if session[:lang_code].nil?
        I18n.locale = Lang::Default
        session[:lang_code] = Lang::Default
      else
        I18n.locale = session[:lang_code]
      end
    else
      I18n.locale = @user.profile.lang.code
    end
    @lang = Lang.where(code: I18n.locale).first
  end

  def set_counter
    @items_counter = Item.cached_counter
  end

  #for administration purposes

  def save_audit_info
    act = action_name
    ctrl = controller_name
    resource_id = resource.try(:id)
    admin_id = current_admin_user.try(:id)

    entry = AuditEntry.create resource_id: resource_id, admin_id: admin_id,
                           event_type: act, resource_type: ctrl.singularize
  end

  def init_special_variables
    @special_vars = {
        body: {
            class: ''
        }
    }
  end

  def cities_list
    country = IpService.ip_country request.remote_ip
    @cities = Rails.cache.fetch("cities/#{country}", expires_in: 1.hour) do
      if country.nil?
        City.all
      else
        City.country_group country
      end
    end
  end

  def langs_list
    @langs = Rails.cache.fetch('langs/list', expires_in: 30.minutes) do
      Lang.all
    end
  end

  def currencies_list
    @currencies = Rails.cache.fetch('currencies/list', expires_in: 6.hours) do
      Currency.all
    end
  end

  def favs_counter
    key = current_user ? "fav-counters/users/#{current_user.id}" : "fav-counters/users/#{session.id}"
    @favs_counter = Rails.cache.fetch(key, expires_in: 6.hours) do
      if current_user
        ::Favorite.where(user: current_user).size
      else
        ::Favorite.where(session: session.id).size
      end
    end
  end

  def analytics
    @analytics = Rails.cache.fetch('analytics', expires_in: 6.hours) do
      Analytic.where(active: true)
    end
  end
end
