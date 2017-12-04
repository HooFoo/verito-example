class AddMobileToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :mobile, :string
    add_index :users, :mobile, unique: true
  end
end
