class AddMobileToTextPages < ActiveRecord::Migration[5.0]
  def change
    add_column :text_pages, :mobile, :text
  end
end
