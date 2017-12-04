class AddFilialToItem < ActiveRecord::Migration[5.0]
  def change
    add_reference :items, :filial
  end
end
