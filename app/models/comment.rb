class Comment < ActiveRecord::Base
  attr_accessible :body, :user_id
  validates_presence_of :body

  belongs_to :user
  belongs_to :issue

end
