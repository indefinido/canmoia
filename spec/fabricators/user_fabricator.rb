Fabricator(:user) do
  name      { Forgery(:name).full_name }
  email      { Forgery(:internet).email_address }
end

Fabricator(:responsible, from: :user) do
end
