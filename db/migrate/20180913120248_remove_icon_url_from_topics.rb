class RemoveIconUrlFromTopics < ActiveRecord::Migration[5.1]
  def change
    remove_column :topics, :icon_url, :string
  end
end
