FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "username #{n}" } 
    password 'password'
    admin false
  end
end