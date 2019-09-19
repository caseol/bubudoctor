class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  # GET /appointments
  # GET /appointments.json
  def index
    if params["appointments_date"].blank?
      _beginning = Time.now.beginning_of_day
      _finishing = Time.now.end_of_day
      if current_user.admin?
        @appointments = Appointment.where(user_id: current_user.id).where("appointment_date between (?) and (?)", _beginning, _finishing).order(appointment_date: :asc).all
      else
        @appointments = Appointment.where(user_id: current_user.parent).where("appointment_date between (?) and (?)", _beginning, _finishing).order(appointment_date: :asc).all
      end
    else
      if current_user.admin?
        _beginning = Date::strptime(params["appointments_date"], "%d/%m/%Y").beginning_of_day
        _finishing = Date::strptime(params["appointments_date"], "%d/%m/%Y").end_of_day
        @appointments = Appointment.where(user_id: current_user.id).where("appointment_date between (?) and (?)", _beginning, _finishing).order(appointment_date: :asc).all
      else
        @appointments = Appointment.where(user_id: current_user.parent).where("appointment_date between (?) and (?)", _beginning, _finishing).order(appointment_date: :asc).all
      end
    end
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
    respond_to :html, :js
  end

  # GET /appointments/1/edit
  def edit
    respond_to :html, :js, :json#, layout: false
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.user_id = (current_user.admin? && current_user.parent.blank?) ? current_user.id : current_user.parent
    # verifica se o usuário já existe, caso contrário cria um novo
    if @appointment.patient_id.blank?
      patient = Patient.new(enable_complete_validation: false, name: params['search_patient'], mobile: params['patient_mobile'], health_insurance: params['patient_health_insurance'], user_id: @appointment.user_id)
    else
      patient = Patient.find_by_id(@appointment.patient_id)
      if patient.health_insurance != params['patient_health_insurance']
        patient.health_insurance = params['patient_health_insurance']
      end
      if patient.mobile != params['patient_mobile']
        patient.mobile = params['patient_mobile']
      end
    end
    patient.enable_complete_validation=false
    patient.save
    @appointment.patient = patient

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, notice: 'Consulta agendada com sucesso' }
        format.js { flash.now[:notice] = 'Consulta agendada com sucesso'}
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new }
        format.js { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        patient = Patient.find_by_id(@appointment.patient_id)
        if patient.health_insurance != params['patient_health_insurance']
          patient.health_insurance = params['patient_health_insurance']
        end
        if patient.mobile != params['patient_mobile']
          patient.mobile = params['patient_mobile']
        end
        patient.enable_complete_validation=false
        patient.save
        format.html { redirect_to @appointment, notice: 'Consulta atualizada com sucesso' }
        format.js { flash.now[:notice] = 'Consulta atualizada com sucesso'}
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.js { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html {redirect_to protocol_url, notice: 'Consulta apagada com sucesso'}
      format.js {flash.now[:notice] = 'Consulta apagada com sucesso'}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:user_id, :patient_id, :appointment_date, :appointment_kind, :status, :obs)
    end
end
