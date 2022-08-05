ActiveAdmin.register Article do

	# See permitted parameters documentation:
	# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
	#
	# Uncomment all parameters which should be permitted for assignment
	#
	# permit_params :title, :body, :status, :user, :user_id, :u_id
	#
	# or
	#
	# permit_params do
	#   permitted = [:title, :body, :status, :user, :user_id, :u_id]
	#   permitted << :other if params[:action] == 'create' && current_user.admin?
	#   permitted
	# end
	actions :all, :except => [:destroy, :edit] 
	permit_params :body, :U, :title, :status

	filter :id
	filter :title
	filter :u_id

	index do
		selectable_column
		id_column
		column :title
		column :created_at
		column :updated_at
		column :status
		column :u
	end

	show do
		attributes_table do
			row :title
			row :body
			row :created_at
			row :updated_at
			row :status
			row :u
		end
		active_admin_comments
	end

	form do |f|
		f.inputs do
			f.input :title
			f.input :body
			f.input :status
		end
		f.actions
	end
end
