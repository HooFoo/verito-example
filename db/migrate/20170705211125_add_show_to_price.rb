class AddShowToPrice < ActiveRecord::Migration[5.0]
  def change
    add_column :prices, :show, :boolean
  end
end
