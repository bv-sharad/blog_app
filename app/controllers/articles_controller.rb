class ArticlesController < ApplicationController
	def index
		@articles = Article.all
	end
	def show
		@article = Article.find_by(id: params[:id])
		redirect_to root_path if @article.nil?
	end
	def new
		@article = Article.new
	end
	def create
		@article = Article.new(article_params)
		if @article.save
			redirect_to @article
		else
			flash[:al] = "Please enter unique title and atleast 10 letters in body"
			render :new, status: :unprocessable_entity
		end
	end
	def edit
		@article = Article.find_by(id: params[:id])
    redirect_to root_path if @article.nil?
	end
	def update
		@article = Article.find_by(id: params[:id])
		redirect_to root_path if @article.nil?
		if @article.update(article_params)
			redirect_to @article
		else
			render :edit, status: :unprocessable_entity
		end
	end
	def destroy
		@article = Article.find_by(params[:id])
		redirect_to root_path if @article.nil?
		@article.destroy 
		redirect_to root_path, status: :see_other
	end
	private
	def article_params
		params.require(:article).permit(:title, :body, :status, :user)
	end
end
