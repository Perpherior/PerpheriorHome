class AddNameToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :name, :string
  end
end
