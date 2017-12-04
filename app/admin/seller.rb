ActiveAdmin.register_page "Seller" do
  controller do
    def index
      params[:items] = Item.sellers_queue
    end
  end
  content do
    columns do
      column do
        panel I18n.t('admin.manager.headers.queue') do
          render 'admin/seller/dashboard'
        end
      end
    end
  end
end
