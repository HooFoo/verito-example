ActiveAdmin.register_page "OrderAssignation" do
  menu false

  controller do
    def index
      params[:order] = Order.find(params[:order_id])
    end
  end
  content title: proc{ I18n.t("admin.delivery.assign") } do
    columns do
      column do
        render 'admin/delivery/order_assignation_form'
      end
    end
  end
end
