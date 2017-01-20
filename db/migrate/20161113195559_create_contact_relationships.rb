class CreateContactRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :contact_relationships do |t|
      t.integer :contacter_id
      t.integer :contact_id

      t.timestamps
    end
    add_index :contact_relationships, :contacter_id
    add_index :contact_relationships, :contact_id
    add_index :contact_relationships, [:contacter_id, :contact_id], unique: true
  end
end
