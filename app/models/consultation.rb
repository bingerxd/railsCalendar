class Consultation < ApplicationRecord
	belongs_to :user

  def self.ransackable_attributes(auth_object = nil)
    %w[consultation_name created_at email time_end id time_start teacher_name updated_at user_id]
  end
  	def self. ransackable_associations(auth_object = nil)
   		[]
  	end
end
