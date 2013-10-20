class User < ActiveRecord::Base
  attr_accessible :uid, :provider, :nickname, :email, :gravatar_id, :token

  has_many :issues

  def self.find_by_nickname!(nickname)
    where(['lower(nickname) =?', nickname.downcase]).first!
  end

  def self.create_from_auth_hash(hash)
    create!(extract_info(hash))
  end

  def self.find_by_auth_hash(hash)
    conditions = extract_info(hash).slice(:provider, :uid)
    where(conditions).first
  end
  
  def github_profile
    "https://github.com/#{nickname}" if nickname.present?
  end
  
  def github_client
    @github_client ||= Octokit::Client.new(:login => nickname, :oauth_token => token, :auto_traversal => true)
  end
  
  def to_param
    nickname
  end
  
  def to_s
    nickname
  end
  
  def collaborating_issues
    Collaborator.where(:github_user_id => uid).map(&:issue)
  end
  
  private
  
  def self.extract_info(hash)
    provider    = hash.fetch('provider')
    uid         = hash.fetch('uid')
    nickname    = hash.fetch('info',{}).fetch('nickname')
    email       = hash.fetch('info',{}).fetch('email', nil)
    gravatar_id = hash.fetch('extra',{}).fetch('raw_info',{}).fetch('gravatar_id', nil)
    token       = hash.fetch('credentials', {}).fetch('token')

    {
      :provider => provider,
      :token => token,
      :uid => uid,
      :nickname => nickname,
      :email => email,
      :gravatar_id => gravatar_id
    }
  end
end
