class CreateChecklists < ActiveRecord::Migration[5.0]
  def change
    create_table :checklists do |t|
      t.belongs_to :proposal, foreign_key: true
      t.boolean :fifteen
      t.integer :width
      t.integer :height
      t.integer :length
      t.string :brand
      t.string :model
      t.string :serial
      t.string :damage
      t.string :work
      t.boolean :box
      t.boolean :cert
      t.boolean :labels
      t.string :notice

      t.timestamps
    end
  end
end
