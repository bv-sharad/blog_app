class UsersController < ApplicationController
	def new
		@user = User.new
	end
	def create
		@user = User.new(user_params)
		if @user.save
			flash[:notice] = "You've successfully signed up!"
			session[:user_id] = @user.id
			session[:email] = @user.email
			redirect_to "/"
		else
			flash[:al] = "There was a problem signing up."
			redirect_to signup_path
		end
	end
	private
	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end
end
