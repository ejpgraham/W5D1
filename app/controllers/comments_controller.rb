class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create

    @comment = Comment.new(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to comment_url(@comment.parent_comment_id)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
end
