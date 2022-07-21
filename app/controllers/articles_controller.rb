class ArticlesController < ApplicationController

	before_action :load_article, except: [:index, :new, :create]
  
	#index
	def load_article
		@article = Article.find_by(id: params[:id])
		if @article.nil?
			flash[:alert] = "No such article found"
			redirect_to root_path
			return
		end
	end

	def index
		@articles = Article.all
	end

	def new
		@article = Article.new
	end

	def create
		if !current_u
			flash[:alert] = " Please Sign in to continue "
			return
		end
		begin
			@article = Article.new(article_params)
			@article.save!
			redirect_to @article
		rescue => e
			logger.error "letter_controller::create => exception #{e.class.name} : #{e.message}"
			flash[:alert] = "Detailed error: #{e.message}"
			render :new, status: :unprocessable_entity
		end
	end

	def update
		if current_u.id == @article.user_id || current_u.admin
			if @article.update(article_params)
				redirect_to @article
			else
				render :edit, status: :unprocessable_entity
			end
		else
			flash[:alert] = "You are not authorized to edit this article"
			redirect_to article_path(@article)
		end
	end

	def destroy
		if current_u.id == @article.user_id || current_u.admin
			@article.destroy
			redirect_to root_path, status: :see_other
		else
			flash[:alert] = "You are not authorized to delete this article"
			redirect_to article_path(@article)
		end
	end

	private
	def article_params
		params.require(:article).permit(:title, :body, :status, :user)
	end
end
