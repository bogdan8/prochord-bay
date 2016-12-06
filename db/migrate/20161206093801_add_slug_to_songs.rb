class AddSlugToSongs < ActiveRecord::Migration[5.0]
  def up
    add_column :songs, :slug, :string
    add_index :songs, :slug, unique: true
  end

  def down
    remove_column :songs, :slug
  end
end
