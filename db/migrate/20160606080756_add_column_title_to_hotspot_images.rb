class AddColumnTitleToHotspotImages < ActiveRecord::Migration
  def change
    add_column :hotspot_images, :title, :string
  end
end
