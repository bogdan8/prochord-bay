class DeleteColumnColorFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :color, :string
  end
end
