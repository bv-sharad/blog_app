class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	helper_method :current_user, :current_name

	def current_user
			@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
	def current_name
			@current_name ||= session[:email] if session[:user_id] && session[:email]
	end
end
