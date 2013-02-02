class Blob < ActiveRecord::Base
  attr_accessible :authentication_id, :branch, :head_sha, :path, :repository_name

  belongs_to :authentication

  def self.create_with_github_hashes(current_authentication, authentication, repo, tree)
    if current_authentication
      name = authentication.name

      create! do |repository|
        repository[:authentication_id] = authentication.id
        repository[:branch] = 'master'
        repository[:head_sha] = tree[:sha]
        repository[:path] = tree[:path]
        repository[:repository_name] = repo[:name]
      end
    end
  rescue Github::Error::ServiceError => e
    logger.info e.message
  end

  def blob(current_authentication)
    if current_authentication
      github = current_authentication.github
      github.git_data.trees.get authentication.name, repository_name, head_sha
    end
  end
end
