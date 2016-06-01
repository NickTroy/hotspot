class CreateInterfaces < ActiveRecord::Migration
  def change
    create_table :interfaces do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
