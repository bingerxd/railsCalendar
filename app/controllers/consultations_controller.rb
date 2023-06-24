class ConsultationsController < ApplicationController
  before_action :set_consultation, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show, :export]
  #before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy, :import]
  # GET /consultations or /consultations.json
  def index
    @consultations = Consultation.all
  end

  # GET /consultations/1 or /consultations/1.json
  def show
  end

  # GET /consultations/new
  def new
    #@consultation = Consultation.new
    @consultation = current_user.consultations.build
  end

  # GET /consultations/1/edit
  def edit
  end

  # POST /consultations or /consultations.json
  def create
    #@consultation = Consultation.new(consultation_params)
    @consultation = current_user.consultations.build(consultation_params)
    respond_to do |format|
      if @consultation.save
        format.html { redirect_to consultation_url(@consultation), notice: "Consultation was successfully created." }
        format.json { render :show, status: :created, location: @consultation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @consultation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /consultations/1 or /consultations/1.json
  def update
    respond_to do |format|
      if @consultation.update(consultation_params)
        format.html { redirect_to consultation_url(@consultation), notice: "Consultation was successfully updated." }
        format.json { render :show, status: :ok, location: @consultation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @consultation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /consultations/1 or /consultations/1.json
  def destroy
    @consultation.destroy

    respond_to do |format|
      format.html { redirect_to consultations_url, notice: "Consultation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @consultation = current_user.consultations.find_by(id: params[:id])
    redirect_to consultations_path, notice: "Not Authorized To Edit This Consultation" if @consultation.nil?
  end

  def authorize_user
    if current_user.id == 8
    else
      correct_user
    end
  end

  def export
      @consultations = Consultation.all
      render xlsx: "consultations", template: "consultations/export"
  end

  def import
    file = params[:file].tempfile
    spreadsheet = Roo::Excelx.new(file).to_a
    spreadsheet.each do |item_array|
      id = item_array[0]
      consultation_name = item_array[1]
      teacher_name = item_array[2]
      email = item_array[3]
      date = item_array[4]
      time_start = item_array[5]
      time_end = item_array[6]

      consultation = Consultation.find_by(id: id) || new
      consultation.update(consultation_name: consultation_name, teacher_name: teacher_name, email: email, date: date, time_start: time_start, time_end: time_end)
    end
    redirect_to consultations_path

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_consultation
      @consultation = Consultation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def consultation_params
      params.require(:consultation).permit(:consultation_name, :teacher_name, :email, :date, :time_start, :time_end, :user_id)
    end
end
