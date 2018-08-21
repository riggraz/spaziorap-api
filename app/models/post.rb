class Post < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: { minimum: 3, maximum: 64 }
  validates :body, length: { minimum: 3 }, allow_nil: true
end
