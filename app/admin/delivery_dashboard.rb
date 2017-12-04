ActiveAdmin.register_page "DeliveryDashboard" do
  menu priority: 2, label: proc{ I18n.t("admin.delivery.label") }

  controller do
    def index
      params[:proposals] = Proposal.for_delivery(current_admin_user.city)
      params[:orders] = Order.for_delivery(current_admin_user.city)
    end
  end

  content title: proc{ I18n.t("admin.delivery.headers.queue") } do
    columns do
      column do
        panel I18n.t('admin.manager.headers.queue') do
          render 'admin/delivery/dashboard'
        end
      end
    end
  end
end
