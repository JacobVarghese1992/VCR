class ChangeTokenTypeToText < ActiveRecord::Migration[5.0]
  def up
  	change_column :push_details, :token,  :text
  end

  def down
  	change_column :push_details, :token,  :string
  end	
end
