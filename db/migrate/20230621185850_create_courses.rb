class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :course_name
      t.string :teacher_name
      t.string :email
      t.string :start_time
      t.string :end_time

      t.timestamps
    end
  end
end
