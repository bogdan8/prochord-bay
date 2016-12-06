class AddLikesCountToSong < ActiveRecord::Migration[5.0]
  def up
    add_column :songs, :likes_count, :integer, default: 0

    Song.reset_column_information
    Song.all.each do |s|
      s.update_attributes(likes_count: s.likes.length)
    end
  end

  def down
    remove_column :songs, :likes_count
  end
end
