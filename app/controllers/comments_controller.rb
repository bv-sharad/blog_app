class CommentsController < ApplicationController
	def create
		@article = Article.find(params[:article_id])
		@comment = @article.comments.create(comment_params)
		puts comment_params
		if @comment.errors
			puts @comment.errors.messages
			redirect_to article_path(@article)
		else
			flash[:alert]
			redirect_to article_path(@article)
		end
	end
	def destroy
		@article = Article.find(params[:article_id])
		@comment = @article.comments.find(params[:id])
		@comment.destroy
		redirect_to article_path(@article), status: 303
	end
	private
	def comment_params
		params.require(:comment).permit(:commenter, :body, :status)
	end
end
