class RemovePerformerAndAddPerformerIdToSongs < ActiveRecord::Migration[5.0]
  def change
    remove_column :songs, :performer, :string
    add_column :songs, :performer_id, :integer
    add_index :songs, :performer_id
  end
end
