class AddDescriptionAndIconUrlToTopics < ActiveRecord::Migration[5.1]
  def change
    add_column :topics, :description, :string
    add_column :topics, :icon_url, :string
  end
end
