class AddAdminUserToOrder < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :admin_user, :foreign_key => true
  end
end
