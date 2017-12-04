ActiveAdmin.setup do |config|

  config.site_title = "Verito Admin"

  config.site_title_image = "icon.png"

  config.authentication_method = :authenticate_admin_user!

  config.authorization_adapter = ActiveAdmin::CanCanAdapter

  config.current_user_method = :current_admin_user

  config.logout_link_path = :destroy_admin_user_session_path

  config.batch_actions = true

  config.skip_before_action :set_city
  config.skip_before_action :set_user
  config.skip_before_action :set_currency
  config.skip_before_action :cities_list
  config.skip_before_action :langs_list
  config.skip_before_action :currencies_list
  config.skip_before_action :favs_counter

  config.localize_format = :long

  config.footer = "Zalogika.ru - версия #{ENV['HEROKU_RELEASE_VERSION']}"


end

class ActiveAdmin::BaseController
  private

  def interpolation_options
    options = {}

    options[:resource_errors] =
        if resource && resource.errors.any?
          "#{resource.errors.full_messages.to_sentence}."
        else
          ""
        end

    options
  end
end