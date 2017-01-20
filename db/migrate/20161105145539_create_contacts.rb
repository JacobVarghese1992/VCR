class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.integer :user_id
      t.integer :contact_person
      t.string :contact_name
      t.timestamps
    end
  end
end
