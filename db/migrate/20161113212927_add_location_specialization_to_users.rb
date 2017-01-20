class AddLocationSpecializationToUsers < ActiveRecord::Migration[5.0]
  def change

  	add_column( :users, :specialization, :string)
  	add_column( :users, :location, :string)

  end
end
