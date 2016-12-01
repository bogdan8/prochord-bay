class AddColumnPopularityToSongs < ActiveRecord::Migration[5.0]
  def change
    add_column :songs, :popularity, :integer, default: 0
  end
end
