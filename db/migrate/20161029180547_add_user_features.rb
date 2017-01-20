class AddUserFeatures < ActiveRecord::Migration[5.0]
  def change
  	add_column( :users, :first_name, :string)
  	add_column( :users, :last_name, :string)
    add_column( :users, :phone_one, :string)
  	add_column( :users, :phone_two, :string)
  	add_column( :users, :d_o_b, :datetime)
  	add_column( :users, :gender, :string)
  	add_column( :users, :role, :string)
  end
end
