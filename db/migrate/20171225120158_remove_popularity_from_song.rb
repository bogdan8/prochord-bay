class RemovePopularityFromSong < ActiveRecord::Migration[5.0]
  def change
    remove_column :songs, :popularity
  end
end
