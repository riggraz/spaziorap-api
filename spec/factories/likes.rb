FactoryBot.define do
  factory :like do
    score 1
    post
    user
  end

  factory :dislike do
    score -1
    post
    user
  end
end
