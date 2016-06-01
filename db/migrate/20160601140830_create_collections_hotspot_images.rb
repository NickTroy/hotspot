class CreateCollectionsHotspotImages < ActiveRecord::Migration
  def change
    create_table :collections_hotspot_images do |t|
      t.references :hotspot_image, index: true, foreign_key: true
      t.integer :collection_id

      t.timestamps null: false
    end
  end
end
