class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.references :book, index: true, foreign_key: true
      t.text :content
      t.integer :word_count

      t.timestamps null: false
    end
  end
end
