require "byebug"

class CommentsController < ApplicationController

  before_action :force_login
  def create
    @comment = Comment.new(comment_params)
    @comment.save
    flash[:errors] = @comment.errors.full_messages
    # byebug
    if @comment.commentable_type == "User"
      redirect_to user_url(@comment.commentable_id)
    else
      redirect_to user_url(Goal.find(@comment.commentable_id).user.id)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    if @comment.commentable_type == "User"
      redirect_to user_url(@comment.commentable_id)
    else
      redirect_to user_url(Goal.find(@comment.commentable_id).user.id)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end

end
