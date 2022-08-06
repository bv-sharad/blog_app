ActiveAdmin.register AdminUser do

	actions :index, :show, :create, :new
  permit_params :email, :password, :password_confirmation

  filter :email
	filter :created_At

	index do
    id_column
    column :email
    column :created_at
  end

	show do
		attributes_table do
			row :id
			row :email
			row :created_at
			row :updated_at
		end
	end

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
