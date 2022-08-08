ActiveAdmin.register Article do

	actions :index, :show, :create, :new
	permit_params :body, :title, :status, :u_id

	filter :id
	filter :u_id
	filter :created_at
	filter :updated_at
	filter :status
	filter :article_id

	index do
		id_column
		column :title
		column :created_at
		column :updated_at
		column :status
		column :user do |article|
			link_to("#{article.u_id}", admin_u_path(article.u_id))
		end
	end

	show do
		attributes_table do
			row :id
			row :title
			row :body
			row :created_at
			row :updated_at
			row :status, :as => :select, :collection => ['public' , 'private' , 'archived' ]
			row :user do |article| 
				link_to("#{article.u.id}: #{article.u.email}", admin_u_path(article.u_id))
			end
			row :Comments do
				link_to('Comments',admin_comments_path({q: {article_id_eq: article.id}}))
			end
		end
	end

	form do |f|
		f.inputs do
			f.input :title
			f.input :body
			f.input :status, :as => :select, :collection => ['public' , 'private' , 'archived']
			f.input :u_id
		end
		f.actions
	end
end
