class CreateCountries < ActiveRecord::Migration[5.0]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
    add_reference :langs, :country
    add_reference :cities, :country
  end
end
