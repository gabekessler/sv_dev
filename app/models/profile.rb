class Profile < ActiveRecord::Base
  belongs_to :user
  
  has_attached_file :avatar, :styles => { 
    :normal => "78x100>",
    :small => "39x50>",
    :square => "50x50#",
    :large => "155x200>" 
    },
    :default_url => lambda {|profile| "http://graph.facebook.com/#{profile.instance.user.fb_uid}/picture?type=:style"}
    # USES FACEBOOK DEFINED SIZES AND DEFAULTS TO FACEBOOK IMAGES
end
