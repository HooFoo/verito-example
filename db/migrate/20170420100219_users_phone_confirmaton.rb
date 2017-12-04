class UsersPhoneConfirmaton < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :mobile_confirmation_token, :string
    add_column :users, :mobile_confirmed_at, :datetime
    add_index :users, :mobile_confirmation_token, unique: true
  end
end
