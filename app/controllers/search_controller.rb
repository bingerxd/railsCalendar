class SearchController < ApplicationController
  def index
    @course_query = Course.ransack(params[:q])
    @consultation_query = Consultation.ransack(params[:q])

    @courses = @course_query.result(distinct: true)
    @consultations = @consultation_query.result(distinct: true)
  end
end
