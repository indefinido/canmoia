Fabricator(:item) do
  value     { Forgery::Monetary.money max: 10000 }
  quantity  { Forgery::Basic.number at_most: 1000 }
  # TODO for more realistic testing on the future product
end
