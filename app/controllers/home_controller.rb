class HomeController < ApplicationController
  def index
    redirect_to issues_path if logged_in?
  end
end