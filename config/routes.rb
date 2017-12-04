Rails.application.routes.draw do

  scope '/yandex_kassa' do
    controller 'yandex_kassa', constraints: { subdomain: 'ssl' } do
      post :check
      post :aviso
      get :success
      get :fail
      post :fail # исключение: при неуспехе оплаты из кошелька Яндекс.Денег приходит запрос методом POST
    end
  end

  namespace :users do
    get 'callback/facebook'
  end

  default_url_options :host => ENV['HOST']

  match 'info/:slug', via: :get, to: 'pages#show'

  mount Ckeditor::Engine => '/ckeditor'

  %w( 404 422 500 403 ).each do |code|
    get code, :to => 'errors#show', :code => code
  end


  get '/courier', to: redirect('/couriers/actions/dashboard')
  namespace :couriers do
    get 'actions/proposal/:id', controller: 'actions', action: 'proposal'
    get 'actions/dashboard'
    get 'actions/checklist/:id', controller: 'actions', action: 'checklist'
    get 'actions/reject/:id', controller: 'actions', action: 'reject'
    post 'actions/reject/:id', controller: 'actions', action: 'reject_complete'
    post 'actions/checklist/:id', controller: 'actions', action: 'checklist_complete', as: 'checklist_complete'
    get 'actions/order/:id', controller: 'actions', action: 'order', as: 'order'
    get 'actions/order_document_form/:id', controller: 'actions', action: 'order_document_form', as: 'order_document_form'
    post 'actions/order_complete/:id', controller: 'actions', action: 'order_complete', as: 'order_complete'
  end

  get 'order/new/:id', controller: 'order', action: 'new', as: 'new_order'
  post 'order/finish', controller: 'order', action: 'finish', as: 'complete_order'
  get 'order/payment/:id', controller: 'order', action: 'payment',as: 'order_payment'
  get 'order/show/:id', controller: 'order', action: 'show',as: 'order_show'
  get 'order/complete/(:id)', controller: 'order', action: 'complete',as: 'order_complete'
  get 'order/payment_incomplete/(:id)', controller: 'order', action: 'payment_incomplete',as: 'order_payment_incomplete'
  get 'order/payment_complete/:id', controller: 'order', action: 'payment_complete', as: 'order_payment_complete'


  get 'favorites/add/:id', controller: 'favorites', action: 'add'
  get 'favorites/remove/:id', controller: 'favorites', action: 'remove'
  get 'favorites/index'

  get 'cathegories/all', defaults: { format: 'json'}
  get 'cathegories/for_parents/:parents', controller: 'cathegories', action: 'for_parents', defaults: { format: 'json'}
  get 'cathegories/by_ids/:ids', controller: 'cathegories', action: 'by_ids', defaults: { format: 'json'}
  get 'cathegories/properties/:id', controller: 'cathegories', action: 'properties',  defaults: { format: 'json'}

  resources :proposals
  post 'proposals/problem', controller: 'proposals', action: :problem
  get 'catalog', controller: 'catalog', action: 'index', as: 'catalog_index'
  get 'catalog/item/:id', controller: 'catalog', action: 'item', as: 'catalog_item'
  post 'catalog/more_items/:page', controller: 'catalog', action: 'more_items', as: 'more_items'
  post 'catalog/filtered', controller: 'catalog', action: 'filtered', as: 'catalog_filtered'
  post 'catalog/price', controller: 'catalog', action: 'price', as: 'add_price'

  namespace :personal do
    get 'lk', as: 'lk'
    get 'city'
    get 'lang'
    patch 'update_profile'
    get 'new_item'
    get 'city_select/:id', action: 'city_select'
    get 'lang_select/:code',  action: 'lang_select'
    get 'currency_select/:id', action: 'currency_select'
    get 'mobile_confirmation'
    post 'confirm_mobile', action: 'confirm_mobile'
    get 'orders', as: 'personal_units'
    get 'update_mobile_confirmation', as: 'request_new_token', action: 'request_confirmation_token'
    get 'update_oauth_confirmation/:id', as: 'request_new_oauth_token', action: 'request_oauth_confirmation_token'
    get 'units', as: 'unit_tab'
    get 'notifications', as: 'notifications_tab'
    get 'profile', as: 'profiles_tab'
    get 'balance', as: 'balance_tab'
    post 'update_notifications', as: 'update_notifications'
    post 'update_mobile', as: 'update_mobile'
    post 'update_email', as: 'update_email'
    post 'update_name', as: 'update_name'
    post 'password_update', as: 'password_update'
    post 'password_change_confirmation', as: 'password_change_confirmation'
    post 'problem', action: 'item_problem'
    post 'assign_oauth', action: 'assign_oauth'
    get 'b2p_card_activation', action: 'confirm_b2p', as: 'confirm_b2p'
    post 'passport', action: 'passport', as: 'passport'
  end

  post 'photos/new', controller: 'photos', action: 'new'
  delete 'photos/delete/:id', controller: 'photos', action: 'delete'

  get 'index/index'
  root 'index#index'

  devise_for :admin_users, ActiveAdmin::Devise.config.merge(controllers: {
                                                              sessions: 'admin_users/sessions'
                                                            })
  ActiveAdmin.routes(self)

  devise_scope :user do
    get "/personal/lk" => "devise/registrations#edit", as: "edit_user_registration" # custom path to sign_up/registration
    post '/users/oauth' => 'users/registrations#oauth', as: 'new_oauth_user'
  end

  devise_for :couriers, controllers: {
      sessions: 'couriers/sessions'
  }

  devise_for :users, controllers: {
      registrations: 'users/registrations',
      sessions: 'users/sessions',
      passwords: 'users/passwords',
      omniauth_callbacks: 'users/callbacks'
  }

end
