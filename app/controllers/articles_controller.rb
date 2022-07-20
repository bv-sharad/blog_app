class ArticlesController < ApplicationController

	before_action :load_article, except: [:index, :new, :create]

	def load_article
		@article = Article.find_by(id: params[:id])
		if @article.nil?
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
		begin
			@article.save!
			redirect_to @article
		rescue => e
			logger.error "letter_controller::create => exception #{e.class.name} : #{e.message}"
			flash[:alert] = "Detailed error: #{e.message}"
			render :new, status: :unprocessable_entity
		end
	end

	def update
		if @article.update(article_params)
			redirect_to @article
		else
			render :edit, status: :unprocessable_entity
		end
	end

	def destroy
		@article.destroy if @article
		redirect_to root_path, status: :see_other
	end

	private
	def article_params
		params.require(:article).permit(:title, :body, :status, :user)
	end
end
