class Post < ApplicationRecord
  belongs_to :user
  belongs_to :topic

  validates :title, presence: true, length: { minimum: 3, maximum: 64 }
  validates :body, length: { minimum: 3 }, allow_nil: true
end
