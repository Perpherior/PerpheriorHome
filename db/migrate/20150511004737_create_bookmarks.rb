class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.references :book, index: true, foreign_key: true
      t.references :chapter, index: true, foreign_key: true
      t.integer :offset

      t.timestamps null: false
    end
  end
end
