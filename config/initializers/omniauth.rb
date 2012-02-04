Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FB_KEY, FB_SECRET, :scope => 'email, publish_stream, offline_access', :iframe => true
end