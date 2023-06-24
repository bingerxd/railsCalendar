class ApplicationController < ActionController::Base
	before_action :set_query

	def set_query
		#@query = Course.ransack(params[:q]) and Consultation.ransack(params[:q])
		@course_query = Course.ransack(params[:q])
    	@consultation_query = Consultation.ransack(params[:q])
	end
end
