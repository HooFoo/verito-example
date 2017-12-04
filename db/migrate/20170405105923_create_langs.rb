class CreateLangs < ActiveRecord::Migration[5.0]
  def change
    create_table :langs do |t|
      t.string :name
      t.string :icon
      t.string :file

      t.timestamps
    end
  end
end
