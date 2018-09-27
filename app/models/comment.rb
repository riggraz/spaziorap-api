class Comment < ApplicationRecord
  has_many :children, class_name: 'Comment', foreign_key: 'parent_id'
  belongs_to :user
  belongs_to :post
  belongs_to :parent, class_name: 'Comment', foreign_key: 'parent_id', optional: true
end
