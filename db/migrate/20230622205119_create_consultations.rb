class CreateConsultations < ActiveRecord::Migration[7.0]
  def change
    create_table :consultations do |t|
      t.string :consultation_name
      t.string :teacher_name
      t.string :email
      t.string :date
      t.string :time_start
      t.string :time_end

      t.timestamps
    end
  end
end
