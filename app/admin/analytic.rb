ActiveAdmin.register Analytic, as: 'Analytics Scripts' do

 permit_params :name, :script, :active

  controller do
    before_action { flash[:notice] = t('admin.notice.critical') }
  end

end
