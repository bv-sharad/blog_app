ActiveAdmin.register Comment do

  actions :index, :show, :create, :new
	permit_params :body, :u_id, :status, :article_id
  
	filter :id
  filter :u_id
  filter :article_id
	filter :created_at
	filter :body
  
  index do
    id_column
    column :created_at
  end
 
	show do
    attributes_table do
      row :id
			row :body
			row :article
      row :created_at
      row :updated_at
      row :u
    end
  end

  form do |f|
    f.inputs do
      f.input :u_id
			f.input :article, :as => :select
      f.input :body
			f.input :status
    end
    f.actions
  end
end
