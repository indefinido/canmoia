class Item
  include Mongoid::Document

  attr_accessor :product_price
  field :quantity, type: Integer

  def price
    self.product_price * self.quantity
  end
end
