class CreatePassports < ActiveRecord::Migration[5.0]
  def change
    create_table :passports do |t|
      t.string :first_name
      t.string :patronymic
      t.string :last_name
      t.string :birth_date
      t.string :persondoc_number
      t.string :persondoc_issdate
      t.string :persondoc_issby
      t.string :address

      t.timestamps
    end
  end
end
