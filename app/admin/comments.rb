ActiveAdmin.register Comment do

  actions :index, :show, :create, :new
	permit_params :body, :u_id, :status, :article_id
  
	filter :id
  filter :u_id
  filter :article_id
	filter :created_at
	filter :updated_at
	filter :body
  
  index do
    id_column
    column :created_at
		column :Article do |comment|
			link_to("#{comment.article_id}",admin_articles_path("q[id_equals]" => comment.article_id))
		end
		column :User do |comment|
			link_to("#{comment.u_id}", admin_us_path("q[id_equals]" => comment.u_id))
		end
  end
 
	show do
    attributes_table do
      row :id
			row :body
			row :Article do |comment|
				link_to("#{comment.article_id}: #{comment.article.title}", admin_articles_path("q[id_equals]" => comment.article_id))
			end
			row :User do |comment|
				link_to("#{comment.u_id}: #{comment.u.email}", admin_us_path("q[id_equals]" => comment.u_id))
			end
      row :created_at
      row :updated_at
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
