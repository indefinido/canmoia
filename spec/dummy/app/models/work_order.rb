class WorkOrder < ::Order
  include Mongoid::Document
  include Canmoia::Work
end
