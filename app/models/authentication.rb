class Authentication < ActiveRecord::Base
  attr_accessible :name, :provider, :screen_name, :uid, :user_id

  belongs_to :user
  has_many :blobs

  def github
    Github.new oauth_token: token
  end

  def update_sources(current_user)
    if current_user
      current_authentication = current_user.authentications.first

      if blobs.empty?
        current_authentication.github.repos.all.each do |repo|
          begin
            trees = github.git_data.trees.get name, repo[:name], 'master', 'recursive' => true
            if trees[:tree]
              trees[:tree].each do |tree|
                if tree[:type] == 'blob'
                  Blob.create_with_github_hashes(current_authentication, self, repo, tree)
                end
              end
            end
          rescue Github::Error::ServiceError => e
            logger.info e.message
          end
        end
      end

      reload!
      blobs.each do |blob|
        blob.delay.update_content current_authentication
      end
    end
  end
  handle_asynchronously :update_sources

  def sources
    blobs.map do |blob|
      blob.content
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
