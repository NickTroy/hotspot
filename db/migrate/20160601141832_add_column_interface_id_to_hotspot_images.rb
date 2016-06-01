class AddColumnInterfaceIdToHotspotImages < ActiveRecord::Migration
  def change
    add_reference :hotspot_images, :interface, index: true, foreign_key: true
  end
end
