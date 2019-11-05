class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums do |t|
      t.string :title
      t.text :image
      t.integer :artist_id

      t.timestamps
    end
  end
end
