class CreatePushDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :push_details do |t|
      t.integer  :user_id
      t.string   :token	
      t.timestamps
    end
    add_index :push_details, :user_id
  end
end
