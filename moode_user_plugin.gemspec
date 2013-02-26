$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "moode_user_plugin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "moode_user_plugin"
  s.version     = MoodeUserPlugin::VERSION
  s.authors     = ["Li Shoubo"]
  s.email       = ["litttlan@gmail.com"]
  s.homepage    = ""
  s.summary     = "Moode User"
  s.description = "Moode User"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.10"
  s.add_dependency 'haml', '~> 3.1.7'
  s.add_dependency 'httparty', '~> 0.10.2'
  s.add_dependency 'bootstrap-sass', '~> 2.2.2.0'
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'haml-rails', '~> 0.3.5'
end
