class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.belongs_to :item, foreign_key: true
      t.integer :payment
      t.string :payment_type
      t.string :aasm_state
      t.belongs_to :status, foreign_key: true
      t.string :delivery_type
      t.string :address
      t.string :mobile
      t.belongs_to :user, foreign_key: true
      t.belongs_to :city, foreign_key: true
      t.boolean :action
      t.belongs_to :courier, foreign_key: true

      t.timestamps
    end
  end
end
