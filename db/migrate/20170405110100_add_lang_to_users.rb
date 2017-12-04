class AddLangToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :profiles, :lang, index: true
    add_foreign_key :profiles, :langs
  end
end
