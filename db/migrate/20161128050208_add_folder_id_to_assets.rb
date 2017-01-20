class AddFolderIdToAssets < ActiveRecord::Migration[5.0]
   def up 
    add_column :assets, :folder_id, :integer
    add_index :assets, :folder_id
  end
  
  def down 
    remove_column :assets, :folder_id
  end
end


