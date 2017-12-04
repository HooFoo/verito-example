ActiveAdminRole.configure do |config|
  # [Required:Hash]
  # == Role | default: { guest: 0, support: 1, staff: 2, manager: 3, admin: 99 }
  config.roles = { guest: 0, support: 1, staff: 2, manager: 3, delivery_manager: 4, seller: 5, call: 6, accountant: 7, admin: 99 }

  # [Optional:Array]
  # == Special roles which don't need to manage on database
  config.super_user_roles = [:admin]
  config.guest_user_roles = [:guest]

  # [Optional:String]
  # == User class name | default: 'AdminUser'
  config.user_class_name = "AdminUser"

  # [Optional:Symbol]
  # == Default permission | default: :cannot
  config.default_state = :cannot
end
