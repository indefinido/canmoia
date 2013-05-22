class Item
  include Mongoid::Document
  field :value, type: Float
  field :quantity, type: Integer
end
