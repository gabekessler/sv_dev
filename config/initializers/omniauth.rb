Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FB_KEY, FB_SECRET, :scope => 'friends_status', :display => 'popup'
end