class AddAvatarToPerformers < ActiveRecord::Migration[5.0]
  def up
    add_attachment :performers, :avatar
  end

  def down
    remove_attachment :performers, :avatar
  end
end
