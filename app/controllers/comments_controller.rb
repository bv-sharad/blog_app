class CommentsController < ApplicationController
	before_action :load_article

	def load_article
		@article = Article.find(id: params[:id])
		if @article.nil?
			redirect_to article_path(@article)
			return
			article_path(@article) 
		end
	end

	def create
		comment_params.merge!(:article_id => @article.id)
		@comment = Comment.create(comment_params)
		if @comment.errors
			redirect_to article_path(@article)
		else
			redirect_to article_path(@article)
		end
	end

	def destroy
		@comment = @article.comments.find(params[:id])
		if @comment.nil?
			redirect_to article_path(@article)
			return
		end
		@comment.destroy
		redirect_to article_path(@article), status: 303
	end

	private
	def comment_params
		params.require(:comment).permit(:commenter, :body, :status)
	end
end
