class CreateCurrencies < ActiveRecord::Migration[5.0]
  def change
    create_table :currencies do |t|
      t.string :name
      t.float :rate
      t.belongs_to :country
      t.string :icon

      t.timestamps
    end
  end
end
