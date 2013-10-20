class Issue < ActiveRecord::Base
  attr_accessible :repository, :title, :body
  validates_presence_of :repository, :title, :body, :user_id
  
  belongs_to :user
end
