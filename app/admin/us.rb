ActiveAdmin.register U do

  actions :index, :show, :create, :new
	permit_params :email, :password
  
	filter :id
  filter :email
	filter :created_at
	filter :updated_at
  
  index do
    id_column
    column :email
    column :created_at
  end
 
	show do
    attributes_table do
			row :id
      row :email
      row :Articles do
        link_to('Articles',admin_articles_path("q[u_id_equals]" => u.id))
       end
			row :Comments do
				link_to 'Comments',admin_comments_path("q[u_id_equals]" => u.id)
			end
			row :created_at
			row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
    end
    f.actions
  end

end
