class AddNestedSetForCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :cathegories, :lft, :integer, :null => true, :index => true
    add_column :cathegories, :rgt, :integer, :null => true, :index => true
    Cathegory.rebuild!
  end
end
