class CreatePlaylists < ActiveRecord::Migration[6.0]
  def change
    create_table :playlists do |t|
      t.string :name
      t.text :image, :default => "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSGFUcNq0Ipw2XKxQAjXs49czXukGr-7rnIZSqpx3lrliTA8vvd"

      t.timestamps
    end
  end
end
