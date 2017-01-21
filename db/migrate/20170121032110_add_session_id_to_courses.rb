class AddSessionIdToCourses < ActiveRecord::Migration[5.0]
  def change

  	add_column( :courses, :session_id, :string)

  end
end
