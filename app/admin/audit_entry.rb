ActiveAdmin.register AuditEntry do
  actions :show, :index

  index do
    column :resource do |entry|
      begin
        res = entry.resource_type.camelize.constantize
        item = res.find(entry.resource_id)
        auto_link(item)
      rescue
        entry.resource_id
      end
    end
    column :resource_type
    column :event_type
    column :admin do |entry|
      begin
        admin = AdminUser.find(entry.admin_id)
        auto_link(admin)
      rescue
        entry.admin_id
      end
    end
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :resource do |entry|
        begin
          res = entry.resource_type.capitalize.constantize
          item = res.find(entry.resource_id)
          auto_link(item)
        rescue
          entry.resource_id
        end
      end
      row :resource_type
      row :event_type
      row :admin do |entry|
        begin
          admin = AdminUser.find(entry.admin_id)
          auto_link(admin)
        rescue
          entry.admin_id
        end
      end
      row :created_at
    end
    active_admin_comments
  end
end
