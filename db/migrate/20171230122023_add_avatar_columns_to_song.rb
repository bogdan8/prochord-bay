class AddAvatarColumnsToSong < ActiveRecord::Migration[5.0]
  def up
    add_attachment :songs, :avatar
  end

  def down
    remove_attachment :songs, :avatar
  end
end
