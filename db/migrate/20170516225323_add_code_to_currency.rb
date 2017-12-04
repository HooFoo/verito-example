class AddCodeToCurrency < ActiveRecord::Migration[5.0]
  def change
    add_column :currencies, :code, :string
  end
end
