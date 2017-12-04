ActiveAdmin.register TextPage do
  permit_params :slug, :text, :mobile, :draft, :tags => []
  batch_action :destroy, false
  actions :all, except: :destroy

  index do
    id_column
    column :slug
    column :draft
    column :system
    column :tags
    actions
  end

  show do
    attributes_table do
      row :id
      row :slug do
        link_to text_page.slug.capitalize, "/info/#{text_page.slug}"
      end
      row :draft
      row :draft_link do
        link_to 'Preview', "/info/#{text_page.slug}?key=#{text_page.draft_key}" if text_page.draft
      end
      row :system
      row :preview do
        text_page.text.html_safe
      end
      row :mobile_preview do
        text_page.mobile.html_safe
      end
      row :tags
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do|f|
    f.inputs do
      f.input :slug
      f.input :text, as: :ckeditor
      f.input :mobile, as: :ckeditor
      f.input :draft
      f.input :tags, as: :array
    end
    f.actions
  end

  action_item :remove, only: :show, if: -> { ! text_page.system } do
    link_to 'Remove', "/admin/text_pages/#{text_page.id}/remove"
  end

  member_action :remove, method: :get do
    page = TextPage.find params[:id]
    if page.system
      redirect_to admin_text_page_path(page), notice: "System pages can't be removed"
    else
      page.destroy
      redirect_to admin_text_pages_path, notice: "Page removed"
    end
  end
end