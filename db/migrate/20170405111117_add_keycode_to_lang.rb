class AddKeycodeToLang < ActiveRecord::Migration[5.0]
  def change
    add_column :langs, :code, :string
  end
end
