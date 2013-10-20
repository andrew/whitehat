class Issue < ActiveRecord::Base
  attr_accessible :repository, :title, :body
  validates_presence_of :repository, :title, :body, :user_id
  
  belongs_to :user
  has_many :collaborators
  
  after_create :create_collaborators
  
  def github_url
    "https://github.com/#{repository}"
  end
  
  def create_collaborators
    user.github_client.collaborators(repository).each do |user|
      puts user
      collaborators.create(:github_user_id => user.id)
    end
  end
end
