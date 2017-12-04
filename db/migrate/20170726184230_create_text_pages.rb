class CreateTextPages < ActiveRecord::Migration[5.0]
  def change
    create_table :text_pages do |t|
      t.string :slug, index: true
      t.text :text
      t.boolean :draft, default: true
      t.boolean :system
      t.string :draft_key
      t.string :tags, array: true, default: []

      t.timestamps
    end
  end
end
