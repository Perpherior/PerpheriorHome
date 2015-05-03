class DeleteNameFromUsers < ActiveRecord::Migration
  def change
  	remove_column :admins, :name
  end
end
