class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.string :title
      t.string :cached_slug

      t.timestamps
    end

    change_column :cities, :id, :bigint, unique: true, null: false, auto_increment: false
  end
end
