class IssuesController < ApplicationController
  before_filter :ensure_logged_in

  def index
    @reported_issues = current_user.issues
  end
  
  def show
    @issue = Issue.find(params[:id])
  end
  
  def new
    @issue = Issue.new
  end
  
  def create
    @issue = current_user.issues.build(params[:issue])
    if @issue.save
      redirect_to @issue
    else
      render :new
    end
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  private
  def issue_params
    params.require(:issue).permit(:repository, :title, :body)
  end
end