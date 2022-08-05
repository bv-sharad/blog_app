ActiveAdmin.register U do

	# See permitted parameters documentation:
	# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
	#
	# Uncomment all parameters which should be permitted for assignment
	#
	# permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :admin, :article_id, :comment_id
	#
	# or
	#
	# permit_params do
	#   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :admin, :article_id, :comment_id]
	#   permitted << :other if params[:action] == 'create' && current_user.admin?
	#   permitted
	# end
	actions :all, :except => [:destroy, :edit]
	permit_params :body, :U, :title, :status

	filter :id
	filter :email
	filter :articles

	index do
		selectable_column
		id_column
		column :email
		column :created_at
		column :updated_at
		column :articles
	end

	show do
		attributes_table do
			row :email
			row :created_at
			row :updated_at
			row :articles
			row :admin
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
