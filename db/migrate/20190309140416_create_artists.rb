class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      # t.integer :id, options: 'PRIMARY KEY'
      t.string :title
      t.string :cached_slug

      t.timestamps
    end

    change_column :artists, :id, :bigint, unique: true, null: false, auto_increment: false

  end
end
