Fabricator(:item) do
  product_price { Forgery::Monetary.money(max: 10000).to_f }
  quantity      { Forgery::Basic.number at_most: 1000 }
  # TODO for more realistic testing on the future product
end
