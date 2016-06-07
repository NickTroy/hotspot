class AddColumnCollectionsLimitCountToInterfaces < ActiveRecord::Migration
  def change
    add_column :interfaces, :collections_limit_count, :integer
  end
end
