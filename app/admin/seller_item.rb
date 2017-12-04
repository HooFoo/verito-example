ActiveAdmin.register_page "SellerItem" do
  menu false

  controller do
    def index
      params[:item] = Item.find(params[:item_id])
    end
  end

  content do
    render 'admin/seller/seller_item'
  end

end
