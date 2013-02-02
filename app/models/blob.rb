class Blob < ActiveRecord::Base
  attr_accessible :authentication_id, :branch, :head_sha, :path, :repository_name

  belongs_to :authentication

  def self.ext_map
    {
      ".adb" => "ada",
      ".ahk" => "ahk",
      ".arc" => "arc",
      ".as" => "actionscript",
      ".asm" => "asm",
      ".asp" => "asp",
      ".aw" => "php",
      ".b" => "b",
      ".bat" => "bat",
      ".befunge" => "befunge",
      ".bmx" => "bmx",
      ".boo" => "boo",
      ".c-objdump" => "c-objdump",
      ".c" => "c",
      ".cfg" => "cfg",
      ".cfm" => "cfm",
      ".ck" => "ck",
      ".cl" => "cl",
      ".clj" => "clj",
      ".cmake" => "cmake",
      ".coffee" => "coffee",
      ".cpp" => "cpp",
      ".cppobjdump" => "cppobjdump",
      ".cs" => "csharp",
      ".css" => "css",
      ".cw" => "cw",
      ".d-objdump" => "d-objdump",
      ".d" => "d",
      ".darcspatch" => "darcspatch",
      ".diff" => "diff",
      ".duby" => "duby",
      ".dylan" => "dylan",
      ".e" => "e",
      ".ebuild" => "ebuild",
      ".eclass" => "eclass",
      ".el" => "lisp",
      ".erb" => "erb",
      ".erl" => "erlang",
      ".f90" => "f90",
      ".factor" => "factor",
      ".feature" => "feature",
      ".fs" => "fs",
      ".fy" => "fy",
      ".go" => "go",
      ".groovy" => "groovy",
      ".gs" => "gs",
      ".gsp" => "gsp",
      ".haml" => "haml",
      ".hs" => "haskell",
      ".html" => "html",
      ".hx" => "hx",
      ".ik" => "ik",
      ".ino" => "ino",
      ".io" => "io",
      ".j" => "j",
      ".java" => "java",
      ".js" => "javascript",
      ".json" => "json",
      ".jsp" => "jsp",
      ".kid" => "kid",
      ".lhs" => "lhs",
      ".lisp" => "lisp",
      ".ll" => "ll",
      ".lua" => "lua",
      ".ly" => "ly",
      ".m" => "objectivec",
      ".mak" => "mak",
      ".man" => "man",
      ".mao" => "mao",
      ".matlab" => "matlab",
      ".md" => "markdown",
      ".minid" => "minid",
      ".ml" => "ml",
      ".moo" => "moo",
      ".mu" => "mu",
      ".mustache" => "mustache",
      ".mxt" => "mxt",
      ".myt" => "myt",
      ".n" => "n",
      ".nim" => "nim",
      ".nu" => "nu",
      ".numpy" => "numpy",
      ".objdump" => "objdump",
      ".ooc" => "ooc",
      ".parrot" => "parrot",
      ".pas" => "pas",
      ".pasm" => "pasm",
      ".pd" => "pd",
      ".phtml" => "phtml",
      ".pir" => "pir",
      ".pl" => "perl",
      ".po" => "po",
      ".py" => "python",
      ".pytb" => "pytb",
      ".pyx" => "pyx",
      ".r" => "r",
      ".raw" => "raw",
      ".rb" => "ruby",
      ".rhtml" => "rhtml",
      ".rkt" => "rkt",
      ".rs" => "rs",
      ".rst" => "rst",
      ".s" => "s",
      ".sass" => "sass",
      ".sc" => "sc",
      ".scala" => "scala",
      ".scm" => "scheme",
      ".scpt" => "scpt",
      ".scss" => "scss",
      ".self" => "self",
      ".sh" => "sh",
      ".sml" => "sml",
      ".sql" => "sql",
      ".st" => "smalltalk",
      ".tcl" => "tcl",
      ".tcsh" => "tcsh",
      ".tex" => "tex",
      ".textile" => "textile",
      ".tpl" => "smarty",
      ".twig" => "twig",
      ".txt" => "text",
      ".v" => "verilog",
      ".vala" => "vala",
      ".vb" => "vbnet",
      ".vhd" => "vhdl",
      ".vim" => "vim",
      ".weechatlog" => "weechatlog",
      ".xml" => "xml",
      ".xq" => "xquery",
      ".xs" => "xs",
      ".yml" => "yaml",
    }
  end

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
    ext = File.extname(path) || File.basename(path)
    Blob.ext_map[ext]
  end

  def update_content(current_authentication)
    if current_authentication
      blob = Rails.cache.fetch "blob_#{head_sha}", expires_in: 1.hour do
        begin
          github = current_authentication.github
          github.git_data.blobs.get authentication.name, repository_name, head_sha
        rescue Github::Error::NotFound => e
          logger.info e.message
        end
      end
    end
  end

  def content
    blob = Rails.cache.read "blob_#{head_sha}"
    content = Base64.decode64 blob[:content]
    { language: language, content: content  }
  end

end
