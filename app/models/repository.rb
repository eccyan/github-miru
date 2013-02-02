class Repository < ActiveRecord::Base
  attr_accessible :authentication_id, :branch, :head_sha, :name

  belongs_to :authentication

  def self.create_with_authentication_and_repo_hash(current_authentication, authentication, repo_hash)
    if current_authentication
      name = authentication.name
      repo_name = repo_hash[:name]

      github = current_authentication.github
      ref = github.git_data.references.get name, repo_name, 'heads/master'

      create! do |repository|
        repository[:authentication_id] = authentication.id
        repository[:branch] = 'master'
        repository[:head_sha] = ref[:object][:sha]
        repository[:name] = repo_name
      end
    end
  rescue Github::Error::ServiceError => e
    logger.info e.message
  end

  def blob(current_authentication)
    if current_authentication
      github = current_authentication.github
      github.git_data.trees.get authentication.name, name, head_sha
    end
  end
end
