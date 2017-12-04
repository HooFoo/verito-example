ActiveAdmin.register Order, as: "Accountant" do
  actions :all, except: [:update, :edit, :destroy]
  config.per_page = 100
  config.per_page = [50, 100, 150, 200]

  index  download_links: [:csv] do
    currency = Currency.where(code: 'RUB').first
    id_column
    column :item
    column :status
    column :price do |order|
      show_money_with_symbol(order.item, currency)
    end
    column :payment
    column :payment_type
    column :user
  end

  csv do
    id_column
    column :item
    column :status
    column :price do |order|
      show_money_with_symbol(order.item, currency)
    end
    column :payment
    column :payment_type
    column :user
  end

  show do
    tabs do
      tab 'Order' do
        attributes_table do
          row :item
          row :payment
          row :payment_type
          row :delivery_type
          row :user
          row :action
          row :courier
          row :mobile
          row :address
          row :track_number
          row :city
          row :status
          row :created_at
          row :updated_at
          row :admin_user
        end
      end
      tab 'Documents' do
        table_for accountant.item.documents do
          column :id
          column :file do |p|
            image_tag p.file.preview.url
          end
          column :created_at
          column :updated_at
          column(:link) { |p| auto_link(p) }
        end
      end
    end

    active_admin_comments
  end
end
