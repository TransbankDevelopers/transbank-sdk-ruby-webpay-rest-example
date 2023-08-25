source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Transbank SDK
#gem 'transbank-sdk', git: "https://github.com/TransbankDevelopers/transbank-sdk-ruby.git", branch: 'master'
#gem "transbank-sdk", path: "D:/work/continuum/transbank/proyectos/ruby/transbank-sdk-ruby"
gem "transbank-sdk"

gem 'rails', '~> 5.1.7'
gem 'sqlite3'
gem 'puma', '~> 5.6', '>= 5.6.7'
gem 'coderay'
gem 'redcarpet'
gem 'emd'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'


group :development, :test do
  gem 'byebug' 
  gem 'tzinfo-data', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'pry'
  gem 'pry-byebug'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
