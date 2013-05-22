$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "canmoia/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "canmoia"
  s.version     = Canmoia::VERSION
  s.authors     = ["Heitor Salazar Baldelli"]
  s.email       = ["heitor@indefini.do"]
  s.homepage    = "http://indefini.do"
  s.summary     = "Canmoia (can = order, möia = work). The core functionality of Order domain."
  s.description = "The core domain concerns for Orders (Work Orders and Purchase Orders)."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_dependency "mongoid"
  s.add_dependency "workflow_on_mongoid"

  s.add_development_dependency 'workflow_on_mongoid'
  s.add_development_dependency 'awesome_print'
  s.add_development_dependency 'fabrication'
  s.add_development_dependency 'forgery'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'email_spec'
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'mongoid-rspec'
  s.add_development_dependency "sqlite3"
end
