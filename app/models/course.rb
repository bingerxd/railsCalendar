class Course < ApplicationRecord
	belongs_to :user

	def self.ransackable_attributes(auth_object = nil)
    	%w[course_name created_at email end_time id start_time teacher_name updated_at user_id]
  	end
  	def self. ransackable_associations(auth_object = nil)
   		[]
  	end
end
