class AddAttachmentOriginFileToBooks < ActiveRecord::Migration
  def self.up
    change_table :books do |t|
      t.attachment :origin_file
    end
  end

  def self.down
    remove_attachment :books, :origin_file
  end
end
