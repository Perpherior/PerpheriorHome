class CreateZooStops < ActiveRecord::Migration
  def change
    create_table :zoo_stops do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.references :admin, index: true

      t.timestamps null: false
    end
  end
end
