class CreateSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :songs do |t|
      t.string :performer
      t.string :title
      t.text :body
      t.integer :count_views

      t.timestamps
    end
  end
end
