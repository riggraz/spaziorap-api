class Topic < ApplicationRecord
  has_many :posts, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 32 }
end
