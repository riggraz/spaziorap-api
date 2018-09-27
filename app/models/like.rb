class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true
  belongs_to :comment, optional: true

  validates :score, numericality: {
    greater_than_or_equal_to: -1,
    less_than_or_equal_to: 1
  }
end
