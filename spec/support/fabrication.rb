Fabrication.configure do |config|
  config.fabricator_path = 'spec/fabricators'
  config.path_prefix = ENGINE_ROOT_DIR
  config.sequence_start = 10000
end

# TODO Figure out why its not loading automagically
Fabrication::Support.find_definitions
