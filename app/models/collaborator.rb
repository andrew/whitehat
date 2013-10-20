class Collaborator < ActiveRecord::Base
  belongs_to :issue
  attr_accessible :github_user_id
  validates_presence_of :issue_id, :github_user_id
  
  def user
    User.where(:uid => github_user_id).first
  end
end
