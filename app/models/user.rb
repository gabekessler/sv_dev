class User < ActiveRecord::Base
  has_many :authentications, :dependent => :destroy
  has_one :profile, :dependent => :destroy
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  def apply_omniauth(omniauth)
    case omniauth['provider']
    when 'facebook'
      self.apply_facebook(omniauth)
    end
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'], :token =>(omniauth['credentials']['token'] rescue nil))
  end

  def facebook
    @fb_user ||= FbGraph::User.me(self.authentications.find_by_provider('facebook').token)
  end
  
  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
  
  def create_with_omniauth(omniauth)  
    create! do |user|
      logger.debug "EXTRA ---------- #{omniauth['extra']['raw_info'].to_yaml}"
      user.profile.first_name = omniauth['extra']['raw_info']['first_name']
      user.profile.last_name = omniauth['extra']["raw_info"]["last_name"]
      user.email = omniauth['extra']["raw_info"]["email"]
      user.fb_uid = omniauth["uid"]
      user.fb_token = omniauth["credentials"]["token"]
    end
  end


  protected

  def apply_facebook(omniauth)
    if (extra = omniauth['extra']['raw_info'] rescue false)
      self.email = (extra['email'] rescue '')
    end
  end
  
end
