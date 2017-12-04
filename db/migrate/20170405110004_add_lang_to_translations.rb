class AddLangToTranslations < ActiveRecord::Migration[5.0]
  def change
    add_reference :translations, :lang, index: true
    add_foreign_key :translations, :langs
  end
end
