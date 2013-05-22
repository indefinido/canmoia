# Configure Rails Envinronment
ENV["RAILS_ENV"] ||= "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require 'rspec/rails'
require 'rspec/autorun'
require 'rails/mongoid'

require 'email_spec'
require 'fabrication'
require 'forgery'
require 'database_cleaner'

Rails.backtrace_cleaner.remove_silencers!

ENGINE_ROOT_DIR = File.dirname(File.expand_path File.join(__FILE__, '..'))

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{ENGINE_ROOT_DIR}/spec/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Email support
  RSpec.configure do |config|
    config.include EmailSpec::Helpers
    config.include EmailSpec::Matchers
    config.include MailerMacros
  end

  # Fabrication support



  # Database Cleaner support
  config.before(:each) do
    DatabaseCleaner.strategy = :truncation, {:except => %w[  ]}
    DatabaseCleaner.clean
  end

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end
