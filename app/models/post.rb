class Post < ApplicationRecord
  belongs_to :user
  belongs_to :topic

  validates :title, presence: true, length: { minimum: 3, maximum: 64 }
end
