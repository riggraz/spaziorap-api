FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "Post #{n}" }
    body "MyText"
    url "MyString"
    user
    topic
  end
end
