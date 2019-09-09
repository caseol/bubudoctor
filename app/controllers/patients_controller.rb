class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  #before_action :admin_only#, :except => [:show]

  #autocomplete :patient, :name, :display_value => :funky_method#, label_method: :name, full_mode: true #, scopes: [:active_users]
  autocomplete :patient, :name, :display_value => :funky_method, additional_data: [:mobile]

  # GET /patients
  # GET /patients.json
  def index
    respond_to :html, :json, :js
    if current_user.admin?
      @patients = Patient.filter(current_user.id, params["search"]["value"])
    else
      @patients = Patient.filter(current_user.parent, params["search"]["value"])
    end
    @patients.order(protocol_number: :desc).all
    # faz a paginação

  end

  # GET /patients/1
  # GET /patients/1.json
  def show
  end

  # GET /patients/new
  def new
    last_protocol_number = Patient.maximum(:protocol_number)
    @patient = Patient.new(protocol_number: last_protocol_number + 1)
    respond_to :html, :json, :js
  end

  # GET /patients/1/edit
  def edit
    if @patient.protocol_number.blank?
      last_protocol_number = Patient.maximum(:protocol_number)
      @patient.protocol_number = last_protocol_number + 1
    end
    respond_to :html, :js, :json#, layout: false
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
        format.html { redirect_to @patient, notice: 'Paciente atualizado com sucesso!' }
        format.js { flash.now[:notice] = 'Paciente atualizado com sucesso!'}
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.js { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to protocol_path, notice: 'Paciente apagado com sucesso!'}
      format.js   { flash.now[:notice] = 'Paciente apagado com sucesso!'}
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
      params.require(:patient).permit(:search_patient, :protocol_number, :patient_since, :name, :birth, :age, :cpf, :gender, :etnia, :civil_status, :occupation, :scholarity, :zip, :address, :city, :uf, :telephone, :mobile, :email, :indication_by, :health_plan, :plan_validation, :plan_number, :created_at, :updated_at,
                                      :main_complaint, :history_of_disease,
                                      :suffered_accidents, :have_allergy, :suffers_asthma,:cardiopathies,
                                      :previous_surgeries, :convulsions, :diabetes_mellitus, :dyslipidemia,
                                      :childhood, :enteropathies, :gastropathy, :previous_hospitalizations,
                                      :history_has, :metabolic_diseases, :nephropathy, :pneumopathy, :osteopathy,
                                      :thyroid_disease, :suffered_transfusions, :other_diseases, :use_medications,
                                      :about_mother, :mother_lives, :mother_cardiac, :mother_diabetes,
                                      :mother_congenital_disease, :mother_has, :mother_neoplasms, :mother_obesity,
                                      :mother_surgeries, :about_father, :father_lives, :father_cardiac, :father_diabetes,
                                      :father_congenital_disease, :father_has, :father_neoplasms, :father_obesity,
                                      :father_surgeries, :alcoholism, :smoking, :stop_smoking, :ilicit_drugs, :physical_activity,
                                      :aerobic_activity, :other_activity, :sleep_weel, :has_appetite, :intestinal_function,
                                      :renal_function, :menstrual_cycle)
    end
end
