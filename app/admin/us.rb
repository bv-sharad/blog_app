ActiveAdmin.register U do

  actions :index, :show, :create, :new
	permit_params :email, :password
  
	filter :id
  filter :email
	filter :created_at
  
  index do
    id_column
    column :email
    column :created_at
  end
 
	show do
    attributes_table do
      row :email
      row :created_at
      row :updated_at
      row :Articles do
        link_to('Articles',admin_articles_path({q: {u_id_eq: u.id}}))
       end
			row :Comments do
				link_to('Comments',admin_comments_path({q: {u_id_eq: u.id}}))
			end
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
