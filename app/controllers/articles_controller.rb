class ArticlesController < ApplicationController
	before_action :load_user, only: [:create, :update, :destroy, :validate_permission_to_edit_or_delete]
	before_action :load_article, except: [:index, :new, :create]
	before_action :validate_permission_to_edit_or_delete, only: [:update, :destroy]

	def index
		@articles = Article.all
	end

	def new
		@article = Article.new
	end

	def create
		begin
			@params = article_params
			@params.merge!(:u_id => current_u.id)
			@article = Article.create(@params)
			@article.save!
			redirect_to @article
		rescue => e
			flash[:alert] = "Detailed error: #{e.message}"
			redirect_to root_path
		end
	end

	def update
		if @article.update!(article_params)
			redirect_to @article
		else
			render :edit, status: :unprocessable_entity
		end
	end

	def destroy
		@article.destroy!
		redirect_to root_path, status: :see_other
	end

	private
	def article_params
		params.require(:article).permit(:title, :body, :status)
	end

	def load_article
		@article = Article.find_by(id: params[:id])
		if @article.nil?
			flash[:alert] = "No such article found"
			redirect_to root_path
			return
		end
	end

	def validate_permission_to_edit_or_delete
		@current_user_article = current_u.articles.find_by(id: params[:id])
		if @current_user_article.nil? && !current_u.admin
			flash[:alert] = "You are not authorized to edit or delete this article"
			redirect_to article_path(@article)
			return
		end
	end

	def load_user
		if !current_u
			flash[:alert] = " Please Sign in to continue "
			redirect_to root_path
			return
		end
	end
end
