class AddDefaultToSessionId < ActiveRecord::Migration[5.0]
  def change
  	change_column :users, :session_id, :string, default: ""
  end
end
