class AddColumnInterfaceIdToCollectionsHotspotImages < ActiveRecord::Migration
  def change
    add_reference :collections_hotspot_images, :interface, index: true, foreign_key: true
  end
end
