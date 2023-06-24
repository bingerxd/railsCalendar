class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show, :export]
  #before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy, :import]
  # GET /courses or /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1 or /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    #@course = Course.new
    @course = current_user.courses.build
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses or /courses.json
  def create
    #@course = Course.new(course_params)
    @course = current_user.courses.build(course_params)
    respond_to do |format|
      if @course.save
        format.html { redirect_to course_url(@course), notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to course_url(@course), notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url, notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @course = current_user.courses.find_by(id:params[:id])
    redirect_to courses_path, notice: "Not Authorized To Edit This Course" if @course.nil?
  end

  def authorize_user
    if current_user.id == 8
    else
      correct_user
    end
  end

  def export
    @courses = Course.all
    render xlsx: "courses", template: "courses/export"
  end

  def import
      file = params[:file].tempfile
      spreadsheet = Roo::Excelx.new(file).to_a
      spreadsheet.each do |item_array|
        id = item_array[0]
        course_name = item_array[1]
        teacher_name = item_array[2]
        email = item_array[3]
        time_start = item_array[4]
        time_end = item_array[5]
        course = Course.find_by(id: id) || new

        course.update(course_name: course_name, teacher_name: teacher_name, email: email, start_time: time_start, end_time: time_end)
      end
      redirect_to courses_path

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:course_name, :teacher_name, :email, :start_time, :end_time, :user_id)
    end
end
