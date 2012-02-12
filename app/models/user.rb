class User < ActiveRecord::Base
  has_many :authentications, :dependent => :destroy
  has_one :profile, :dependent => :destroy
  has_many(:friendships, :foreign_key => :user_id, :dependent => :destroy)
  has_many(:reverse_friendships, :class_name => :Friendship, :foreign_key => :friend_id_id, :dependent => :destroy)
  has_many :friends, :through => :friendships, :source => :friend_id, :class_name => :User
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :fb_uid, :fb_token, :profile_id, :username
  
  extend FriendlyId
  friendly_id :email, use: :slugged
  
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
  
  def update_with_omniauth(omniauth)
    self.update_attributes(
      :email => omniauth['extra']["raw_info"]["email"],
      :fb_uid => omniauth["uid"],
      :fb_token => omniauth["credentials"]["token"],
      :username => omniauth['extra']["raw_info"]["username"]
    )
    self.profile.update_attributes(
      :first_name => omniauth['extra']['raw_info']['first_name'],
      :last_name => omniauth['extra']["raw_info"]["last_name"],
      :bio => omniauth['extra']["raw_info"]["bio"]
    )
  end
  
  def full_name
    self.profile.first_name + " " + self.profile.last_name
  end
  
  def facebook_friends
    # REFACTOR FOR LARGER POOL OF USERS. MAYBE CREATE FRIENDSHIP ON CALLBACK FROM FB FRIEND SIGN UP
    @facebook_friends = []
    @all_users = User.all
    @user = FbGraph::User.new('me', :access_token => self.fb_token).fetch
    @friends = @user.friends.collect(&:identifier)
    @sv_friends = @all_users.collect {|user| @friends.include?(user.fb_uid) ? user.id : nil}.compact
    @sv_friends.each do |sv_friend|
      user = User.find(sv_friend)
      @facebook_friends << user
    end
    @facebook_friends
  end


  protected

  def apply_facebook(omniauth)
    if (extra = omniauth['extra']['raw_info'] rescue false)
      self.email = (extra['email'] rescue '')
    end
  end
  
end
