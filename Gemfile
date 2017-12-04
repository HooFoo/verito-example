source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'

# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'haml-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'i18n-active_record', :require => 'i18n/active_record'
gem 'nilify_blanks'
gem 'active_admin_editor', github: 'boontdustie/active_admin_editor'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'devise-bootstrap-views'
gem 'formtastic', '>= 3.1.5'
gem 'wannabe_bool'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-vkontakte'
gem 'omniauth-facebook'
gem 'awesome_nested_set'
gem 'activeadmin_addons'





# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'devise', git: 'https://github.com/plataformatec/devise.git', branch: 'master'
gem 'carrierwave'
gem 'rmagick'
gem 'activeadmin', github: 'activeadmin'
gem 'simple_form'
gem 'kaminari'
gem 'rest-client', '~> 1.8'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
gem 'redis-rails'
gem 'redis-namespace'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'dalli'
gem 'memcachier'
gem 'money-rails', '~>1'
gem 'russian_central_bank', github: 'kosmatov/russian_central_bank'
gem 'pg'
gem 'font-awesome-rails'
gem 'aasm'
gem 'active_material', github: 'vigetlabs/active_material'
gem 'cancancan', '~> 1.10'
gem 'active_admin_role'
gem 'ckeditor'
gem 'mini_magick'
gem 'yandex_kassa'
gem 'builder'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  #gem 'spring'
  #gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'better_errors'
  # Use sqlite3 as the database for Active Record
  gem 'dotenv-rails'
  gem 'letter_opener'
  gem 'foreman'
end
gem 'cloudinary'

group :production do
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
