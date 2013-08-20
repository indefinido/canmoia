$:.push File.expand_path("../lib", __FILE__)

require "canmoia/version"

Gem::Specification.new do |s|
  s.name        = "canmoia"
  s.version     = Canmoia::VERSION
  s.authors     = ["Heitor Salazar Baldelli"]
  s.email       = ["heitor@indefini.do"]
  s.homepage    = "http://indefini.do"
  s.summary     = "Canmöia (can = order, möia = work). The core functionality of Order domain."
  s.description = "The core domain concerns for Orders (Work Orders and Purchase Orders)."
  s.license     = 'WTFP'

  s.files = Dir["{app,config,db,lib}/**/*"] + ["WTFP-LICENSE", "Rakefile", "README.md", 'Guardfile']
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", ">= 3"
  s.add_dependency "mongoid"
  s.add_dependency "workflow_on_mongoid"

  s.add_development_dependency 'workflow_on_mongoid'
  s.add_development_dependency 'awesome_print'
  s.add_development_dependency 'fabrication'
  s.add_development_dependency 'forgery'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'growl'
  s.add_development_dependency 'email_spec'
  s.add_development_dependency 'pry-rescue'
  s.add_development_dependency 'pry-stack_explorer'
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'mongoid-rspec'
  s.add_development_dependency 'sqlite3'
end
