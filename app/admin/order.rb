ActiveAdmin.register Order do
  permit_params :courier_id, :mobile, :payment_type, :address, :delivery_type, :city_id,
                :status_id, :track_number,
                :documents_attributes => [:id, :file, :doc_type]

  form do |f|
    f.semantic_errors
    tabs do
      tab 'Order' do
        f.actions
        f.inputs do
          f.input :delivery_type, collection: Order::DeliveryTypes
          f.input :mobile
          f.input :payment_type, collection: Order::PaymentTypes
          f.input :address
          f.input :track_number
          f.input :city, :include_blank => false
          f.input :status, collection: Status.for_proposals, :include_blank => false
        end
      end

      tab 'Documents' do
        f.has_many :documents do |p|
          p.input :file, :as => :file, :hint => image_tag(p.object.file)
          p.input :doc_type
        end
      end
    end
    f.actions
  end

  action_item :assign, only: :show,
              if: proc{  order.aasm_state == 'delivery' }  do
    link_to I18n.t('admin.buttons.assign'), "/admin/orderassignation/?order_id=#{order.id}"
  end

  action_item :complete, only: :show do
    link_to I18n.t('admin.buttons.finish'), "/admin/orders/#{order.id}/finish"
  end

  member_action :finish, method: :get do
    order = Order.find params[:id]
    order.complete
    redirect_to admin_order_path(order), notice: I18n.t('admin.notice.finished')
  end

end
