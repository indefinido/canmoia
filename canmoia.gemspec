$:.push File.expand_path("../lib", __FILE__)

require "canmoia/version"

Gem::Specification.new do |gem|
  gem.name        = "canmoia"
  gem.version     = Canmoia::VERSION
  gem.summary     = %q{Canmöia (can = order, möia = work). The core functionality of Order domain.}
  gem.description = %q{The core domain concerns for Orders (Work Orders and Purchase Orders).}
  gem.license     = 'WTFP'
  gem.authors     = ["Heitor Salazar Baldelli"]
  gem.email       = ["heitor@indefini.do"]
  gem.homepage    = "http://indefini.do"

  gem.files = `git ls-files`.split($/)
  gem.test_files = Dir["spec/**/*"]

  gem.add_dependency "rails", ">= 3"
  gem.add_dependency "mongoid"
  gem.add_dependency "workflow_on_mongoid"

  gem.add_development_dependency 'mongoid'
  gem.add_development_dependency 'workflow_on_mongoid'
  gem.add_development_dependency 'awesome_print'
  gem.add_development_dependency 'fabrication'
  gem.add_development_dependency 'forgery'
  gem.add_development_dependency 'database_cleaner'
  gem.add_development_dependency 'rspec-rails'
  gem.add_development_dependency 'growl'
  gem.add_development_dependency 'email_spec'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'pry-stack_explorer'
  gem.add_development_dependency 'pry-rails'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'mongoid-rspec'
  gem.add_development_dependency 'sqlite3'
end
