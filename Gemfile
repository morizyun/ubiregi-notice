source 'https://rubygems.org'

ruby "2.0.0"

gem 'rails', '3.2.18'

# Haml
gem 'haml-rails'

gem 'jquery-rails'

gem 'newrelic_rpm'
gem 'foreman'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development, :test do
  gem 'sqlite3'
  gem 'pry-rails'
  gem 'pry-coolline'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'
  gem 'rb-readline'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2'
  gem 'coffee-rails', '~> 3.2'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :development do
  # Converter erb => haml
  gem 'erb2haml'
end

group :test do
  gem 'unification_assertion', :git => "git://github.com/soutaro/unification_assertion.git"

  # Rspec
  gem 'rspec-rails'
end

group :production do
  gem 'pg'
  gem 'therubyracer'
  gem 'unicorn'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
