Fabricator(:order) do
  state :opened
  responsible
end

Fabricator(:accepted_order, from: :order) do
  state :accepted
  items(count: Forgery::Basic.number(at_most: 1000))
end
