class AddStockPlaceToItem < ActiveRecord::Migration[5.0]

  def change
    add_column :items, :stock_place, :string
  end

end
