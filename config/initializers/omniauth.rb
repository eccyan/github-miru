Rails.application.config.middleware.use OmniAuth::Builder do
  require 'openid/store/filesystem' 
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: "user,repo,gist"
  provider :openid, :store => OpenID::Store::Filesystem.new('/tmp')
end
