class Blob < ActiveRecord::Base
  attr_accessible :authentication_id, :branch, :head_sha, :path, :repository_name

  belongs_to :authentication

  def self.create_with_github_hashes(current_authentication, authentication, repo, tree)
    if current_authentication
      name = authentication.name

      create! do |blob|
        blob[:authentication_id] = authentication.id
        blob[:branch] = 'master'
        blob[:head_sha] = tree[:sha]
        blob[:path] = tree[:path]
        blob[:repository_name] = repo[:name]
      end
    end
  rescue Github::Error::ServiceError => e
    logger.info e.message
  end

  def language
    {
      '.y' => 'bison',
      '.c' => 'c',
      '.cpp' => 'cpp',
      '.cs' => 'csharp',
      '.css' => 'css',
      '.diff' => 'diff',
      '.flex' => 'flex',
      '.glsl' => 'glsl',
      '.html' => 'html',
      '.htm' => 'html',
      '.java' => 'java',
      '.js' => 'javascript',
      '.tex' => 'latex',
      '.log' => 'log',
      '.m4' => 'm4',
      '.make' => 'makefile',
      'Makefile' => 'makefile',
      '.pas' => 'pascal',
      '.pl' => 'perl',
      '.php' => 'php',
      '.py' => 'python',
      '.rb' => 'ruby',
      '.scala' => 'scala',
      '.sh' => 'sh',
      '.sql' => 'sql',
      '.tcl' => 'tcl',
      '.xml' => 'xml',
    }[File.extname(path)]
  end

  def content(current_authentication)
    if current_authentication
      blob = Rails.cache.fetch "blob_#{head_sha}", expires_in: 1.hour do
        github = current_authentication.github
        github.git_data.blobs.get authentication.name, repository_name, head_sha
      end
      content = Base64.decode64 blob[:content]
      { language: language, content: content  }
    end
  rescue Github::Error::NotFound => e
    logger.info e.message
  end

end
