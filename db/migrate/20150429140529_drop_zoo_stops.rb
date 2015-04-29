class DropZooStops < ActiveRecord::Migration
  def change
  	drop_table :zoo_stops
  end
end
