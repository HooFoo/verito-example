class CreateFilials < ActiveRecord::Migration[5.0]
  def change
    create_table :filials do |t|
      t.belongs_to :city, foreign_key: true
      t.string :address
      t.bigint :phone
      t.string :work_hours
      t.boolean :main

      t.timestamps
    end
  end
end
