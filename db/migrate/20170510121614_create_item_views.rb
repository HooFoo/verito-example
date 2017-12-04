class CreateItemViews < ActiveRecord::Migration[5.0]
  def change
    create_table :item_views do |t|
      t.belongs_to :item, foreign_key: true
      t.string :session
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
    add_column :items, :item_views_count, :integer
  end
end
