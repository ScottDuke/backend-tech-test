class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.string :title
      t.string :cached_slug
      t.references :artist, foreign_key: true
      t.references :city, foreign_key: true

      t.timestamps
    end
  end
end
