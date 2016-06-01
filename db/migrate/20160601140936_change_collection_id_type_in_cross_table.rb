class ChangeCollectionIdTypeInCrossTable < ActiveRecord::Migration
  def self.up
    change_table :collections_hotspot_images do |t|
      t.change :collection_id, :integer, :limit => 8
    end
  end
  
  def self.down
    change_table :collections_hotspot_images do |t|
      t.change :collection_id, :integer, :limit => 4
    end
  end
end
