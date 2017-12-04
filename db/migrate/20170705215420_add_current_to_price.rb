class AddCurrentToPrice < ActiveRecord::Migration[5.0]
  def change
    add_column :prices, :current, :boolean
  end
end
