class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	before_action :update_allowed_parameters, if: :devise_controller?
	  def update_allowed_parameters
		devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:admin, :email, :password)}
		devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:admin, :email, :password, :current_password)}
		end
	end
