class Authentication < ActiveRecord::Base
  attr_accessible :name, :provider, :screen_name, :uid, :user_id

  belongs_to :user
  has_many :blobs

  def github
    Github.new oauth_token: token
  end

  def sources(current_user)
    if current_user
      current_authentication = current_user.authentications.first

      if blobs.empty?
        current_authentication.github.repos.all.each do |repo|
          trees = github.git_data.trees.get name, repo_name, 'master', 'recursive' => true
          trees.each do |tree|
            if tree[:type] == 'blob'
              Repository.create_with_authentication_and_repo_hash(current_authentication, self, repo, tree)
            end
          end
        end

        reload
      end

      blobs.map do |repo|
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
