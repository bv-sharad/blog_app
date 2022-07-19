class CommentsController < ApplicationController
	def create
		@article = Article.find_by(id: params[:article_id])
		redirect_to root_path if @article.nil?
		@comment = @article.comments.create(comment_params)
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
		redirect_to root_path if @article.nil?
		@comment = @article.comments.find(params[:id])
		redirect_to root_path if @comment.nil?
		@comment.destroy
		redirect_to article_path(@article), status: 303
	end
	private
	def comment_params
		params.require(:comment).permit(:commenter, :body, :status)
	end
end
