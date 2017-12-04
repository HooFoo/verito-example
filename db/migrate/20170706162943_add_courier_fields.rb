class AddCourierFields < ActiveRecord::Migration[5.0]
  def change
    add_column :couriers, :name, :string
    add_column :couriers, :delivery_service, :string
    add_reference :couriers, :city, foreign_key: true
    add_reference :proposals, :courier, foreign_key: true
  end
end
