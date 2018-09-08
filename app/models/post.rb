class Post < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  has_many :likes, dependent: :destroy

  validates :body, length: { minimum: 3 }, allow_nil: true
end
