class Authentication < ActiveRecord::Base
  attr_accessible :name, :provider, :screen_name, :uid, :user_id

  belongs_to :user
  has_many :repositories

  def github
    Github.new oauth_token: token
  end

  def sources(current_user)
    if current_user
      current_authentication = current_user.authentications.first

      if repositories.empty?
        current_authentication.github.repos.all.each do |repo_hash|
          Repository.create_with_authentication_and_repo_hash(current_authentication, self, repo_hash)
        end

        reload
      end

      repositories.map do |repo|
        repo.blob current_authentication
      end
    end
  end

  def self.create_with_omniauth(user, auth)  
    create! do |authentication|
      authentication.user_id = user.id
      authentication.provider = auth[:provider]  
      authentication.uid = auth[:uid]  
      authentication.name = auth[:info][:nickname]  
      authentication.token = auth[:credentials][:token]  
      authentication.secret = auth[:credentials][:secret]  
    end
  end  
end
