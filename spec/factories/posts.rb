FactoryBot.define do
  factory :post do
    body "MyText"
    url "MyString"
    user
    topic
  end
end
