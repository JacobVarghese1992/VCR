class AddDefaultValueToRole < ActiveRecord::Migration[5.0]
def up
  change_column :users, :role, :string, :default => :patient
  change_column :users, :gender, :string, :default => :male
end

def down
  change_column :users, :role, :string, :default => nil
  change_column :users, :gender, :string, :default => nil
end
end
