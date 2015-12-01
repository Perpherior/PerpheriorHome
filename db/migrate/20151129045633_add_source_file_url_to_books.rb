class AddSourceFileUrlToBooks < ActiveRecord::Migration
  def change
    add_column :books, :source_url, :string
    add_column :books, :cover_url, :string
  end
end
