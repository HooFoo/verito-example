ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  controller do
    def index
      params[:proposals] = Proposal.for_queue(current_admin_user)
      params[:items] = Item.for_queue(current_admin_user)
      params[:orders] = Order.for_queue(current_admin_user)
    end
  end

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel I18n.t('admin.manager.headers.queue') do
          render 'admin/manager/dashboard'
        end
      end
    end
  end

end
