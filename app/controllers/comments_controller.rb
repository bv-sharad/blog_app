class CommentsController < ApplicationController
	before_action :load_article

	def create
		begin
			comment_params.merge!(:article_id => @article.id)
			@comment = Comment.create(comment_params)
			#@comment = @article.comments.create(comment_params)
		rescue StandardError => e
			logger.error "letter_controller::create => exception #{e.class.name} : #{e.message}"
			flash[:alert] = "Detailed error: #{e.message}"
			render :new, status: :unprocessable_entity
		end
		redirect_to article_path(@article)
	end

	def destroy
		@comment = @article.comments.find(params[:id])
		@comment.destroy
		redirect_to article_path(@article), status: 303
	end

	private
	def comment_params
		params.require(:comment).permit(:commenter, :body, :status, :user_id, :article_id)
	end

	def load_article
		@article = Article.find_by(id: params[:article_id])
		if @article.nil?
			flash[:alert] = "No such article found"
			redirect_to root_path
			return
		end
	end

end
