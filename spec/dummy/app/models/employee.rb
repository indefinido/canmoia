class Employee < User
  include Mongoid::Document
  field :job, type: String
end
