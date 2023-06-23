class AddUserIdToConsultations < ActiveRecord::Migration[7.0]
  def change
    add_column :consultations, :user_id, :integer
    add_index :consultations, :user_id
  end
end
