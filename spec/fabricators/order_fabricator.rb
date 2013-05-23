Fabricator(:order) do
  state       :opened
  items(count: Forgery::Basic.number(at_most: 1000))
end

Fabricator(:accepted_order, from: :order) do
  state :accepted
end

Fabricator(:work_order) do
  after_build do | order, transients |
    order.responsible = Fabricate(:responsible) if order.respond_to? :responsible
  end
  # responsible
end
