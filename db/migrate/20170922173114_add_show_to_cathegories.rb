class AddShowToCathegories < ActiveRecord::Migration[5.0]
  def change
    add_column :cathegories, :show, :boolean, default: true
  end
end
