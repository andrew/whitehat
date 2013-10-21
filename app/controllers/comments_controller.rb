class CommentsController < ApplicationController
  before_filter :ensure_logged_in
  
  def show
    @comment = Comment.find(params[:id])
  end
  
  def new
    @comment = Comment.new
  end
  
  def create
    issue = Issue.find(params[:issue_id])
    @comment = issue.comments.build(params[:comment].merge(user_id: current_user.id))

    if @comment.save
      redirect_to issue
    else
      render :new
    end
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      redirect_to @comment
    else
      render :edit
    end
  end

  def destroy
    flash[:notice] = 'You succesfully deleted a comment.'
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to comment.issue
  end
  
  private
  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end
end