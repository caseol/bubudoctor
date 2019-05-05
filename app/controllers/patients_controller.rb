class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  before_action :admin_only#, :except => [:show]

  # GET /patients
  # GET /patients.json
  def index
    @patients = Patient.all
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
  end

  # GET /patients/new
  def new
    @patient = Patient.new()
    respond_to :html, :json, :js
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)

    # associa paciente ao médico
    @patient.user_id = (current_user.admin? && current_user.parent.blank?) ? current_user.id : current_user.parent

    respond_to do |format|
      if @patient.save
        format.html { redirect_to @patient, notice: 'Paciente criado com sucesso' }
        format.js { flash.now[:notice] = 'Paciente criado com sucesso!'}
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new }
        format.js { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to @patient, notice: 'Patient was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url, notice: 'Patient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:patient_since, :name, :birth, :age, :cpf, :gender, :etnia, :civil_status, :occupation, :scholarity, :zip, :address, :city, :uf, :telephone, :mobile, :email, :indication_by, :health_plan, :plan_validation, :plan_number, :created_at, :updated_at)
    end
end