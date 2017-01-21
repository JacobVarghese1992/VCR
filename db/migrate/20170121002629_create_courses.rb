class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :course_id
      t.string :name

      t.timestamps
    end
  end
end
