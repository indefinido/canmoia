require 'mongoid'
require 'workflow'

module Canmoia
  autoload :Order        , 'canmoia/concerns/order'
  autoload :Work         , 'canmoia/concerns/work'
  autoload :Notification , 'canmoia/features/notification'
end
