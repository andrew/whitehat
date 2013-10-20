class Issue < ActiveRecord::Base
  attr_accessible :repository, :title, :body
  validates_presence_of :repository, :title, :body, :user_id
  
  belongs_to :user
  
  def github_url
    "https://github.com/#{repository}"
  end
  
  def collaborators
    user.github_client.collaborators(repository)
  end
end
