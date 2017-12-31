class AddSlugToPerformers < ActiveRecord::Migration[5.0]
  def change
    add_column :performers, :slug, :string
    add_index :performers, :slug, unique: true
  end
end
