class CreatePhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :photos do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.string :thumbnail_url, null: false
      t.references :album, null: false, foreign_key: true

      t.timestamps
    end
  end
end
