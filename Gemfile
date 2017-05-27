source 'https://rubygems.org'

# Ruby version
ruby '2.3.3'

# General list of gems
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'dotenv-rails'
gem 'devise'
gem 'omniauth' # required for devise_token_auth
gem 'devise_token_auth'
gem 'pundit'
gem 'sendgrid'
gem 'layer-handler'
gem 'friendly_id'
gem 'gravtastic'
gem 'jenkins_api_client'
gem 'delayed_job_active_record'
gem 'daemons'
gem 'mysql2', '~> 0.3.18'
gem 'font-awesome-rails'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'ace-rails-ap'

gem 'redguide-api', git: 'https://github.com/aleksey-hariton/redguide-api.git' # path: '/home/stalker/DEVEL/redguide-api'


# Only Development env gems
group :development do
  gem 'sqlite3'
  gem 'better_errors'
  gem 'foreman'
  gem 'rails_layout'
  gem 'rb-fchange', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-inotify', require: false
  gem 'spring-commands-rspec'
  gem 'web-console'
  gem 'listen', '~> 3.0.5'

  # Guard
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'

  # Spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Pry
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-remote'
  gem 'pry-stack_explorer'
  gem 'pry-rescue'
end

# Only Test env gems
group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
end

# Only Production env gems
group :production do
  gem 'unicorn'
end

# Both Test and Development env gems
group :development, :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'byebug', platform: :mri
end
