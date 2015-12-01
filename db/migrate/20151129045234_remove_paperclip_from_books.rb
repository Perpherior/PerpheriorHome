class RemovePaperclipFromBooks < ActiveRecord::Migration
  def change
    remove_attachment :books, :cover
    remove_attachment :books, :origin_file
  end
end
