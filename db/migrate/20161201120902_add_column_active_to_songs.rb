class AddColumnActiveToSongs < ActiveRecord::Migration[5.0]
  def change
    add_column :songs, :active, :integer, default: 0
  end
end
