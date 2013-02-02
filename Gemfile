source 'https://rubygems.org'

gem 'rails', '3.2.9'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3', :group => :development
gem 'pg', :group => :production
gem 'thin'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn'

# To use debugger
gem 'debugger'

# To use Pry runtime developer console
gem 'pry-rails', :group => :development

# To use RSpec testing
group :test, :development do
  gem 'rspec-rails', '~> 2.0'
  gem 'simplecov', :require => false
  gem 'factory_girl_rails'
  gem 'spork'
  gem 'growl'
  gem 'guard-spork'
end

# To use Devise authentication
gem 'devise'

# To use cancan role 
gem 'cancan'

# To use Twitter Bootstrap
gem 'libv8', '~> 3.11.8'
gem 'therubyracer', :require => 'v8'
gem 'less-rails' #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem 'twitter-bootstrap-rails'

# Deploy with Capistrano
group :development do
  gem 'capistrano'
  gem 'capistrano-ext'
  gem 'capistrano_colors'
  gem 'rvm-capistrano'
end

# To use simple form for view helper
gem 'simple_form'

# To use upload image and image triming
gem 'mini_magick'
gem 'carrierwave'

# To use i!8n templates
gem 'rails-i18n'

# ER diagrams
group :development do
  gem 'rails-erd'
end

# Form helper
gem 'cocoon'

# Using Github API
gem 'github_api'

# Using Omniauth
gem 'omniauth-openid'
gem 'omniauth-github'

# Using IronCache
gem 'iron_cache_rails'

# Setting TimeOut
gem "rack-timeout"
