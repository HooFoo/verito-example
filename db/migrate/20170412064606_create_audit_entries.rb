class CreateAuditEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :audit_entries do |t|
      t.integer :resource_id
      t.integer :admin_id
      t.string :resource_type
      t.string :event_type

      t.timestamps
    end
  end
end
