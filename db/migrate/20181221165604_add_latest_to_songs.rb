class AddLatestToSongs < ActiveRecord::Migration[5.1]
  def change
    add_column :songs, :latest, :boolean, default: false
  end
end
