class RemoveWrongKey < ActiveRecord::Migration[5.0]
  def change
    remove_reference :currencies, :city
  end
end
