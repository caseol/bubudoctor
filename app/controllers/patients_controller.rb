class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  #before_action :admin_only#, :except => [:show]

  #autocomplete :patient, :name, :display_value => :funky_method#, label_method: :name, full_mode: true #, scopes: [:active_users]
  autocomplete :patient, :all, :display_value => :funky_method, additional_data: [:cpf, :mobile, :mobile_work, :health_insurance, :telephone_work, :telephone], full_model: true, order: "patients.name ASC"

  # GET /patients
  # GET /patients.json
  def index
    respond_to :html, :json, :js
    _search_value = params["search"]["value"]
    _field_index = params["order"]["0"]["column"]
    _field_name = params["columns"][_field_index]["data"]
    _order_dir = params["order"]["0"]["dir"]
    if current_user.admin?
      @patients = Patient.filter(current_user.id, _search_value, _field_name, _order_dir)
    else
      @patients = Patient.filter(current_user.parent, _search_value, _field_name, _order_dir)
    end
    @patients.all
    # faz a paginação

  end

  # GET /patients/1
  # GET /patients/1.json
  def show
  end

  # GET /patients/new
  def new
    if current_user.admin?
      _user_id = current_user.id
    else
      _user_id = current_user.parent
    end
    last_protocol_number = Patient.where(user_id: _user_id).maximum(:protocol_number) || 0
    @patient = Patient.new(protocol_number: last_protocol_number + 1)
    respond_to :html, :json, :js
  end

  # GET /patients/1/edit
  def edit
    if @patient.protocol_number.blank?
      if current_user.admin?
        _user_id = current_user.id
      else
        _user_id = current_user.parent
      end
      last_protocol_number = Patient.where(user_id: _user_id).maximum(:protocol_number)  || 0
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
    # sobrescrevendo métodos do autocomplete para pesquisar em diversas colunas (campos)
    def autocomplete_select_clause(model, value_method, label_method, options)
      table_name = model.table_name
      selects = []
      selects << "#{table_name}.#{model.primary_key}"
      selects << (value_method == 'all') ? "#{table_name}.*" : "#{table_name}.#{value_method}"
      selects << "#{table_name}.#{label_method}" if label_method
      options[:additional_data].each { |datum| selects << "#{table_name}.#{datum}" } if options[:additional_data] && (value_method != 'all')
      selects
    end
    def autocomplete_where_clause(term, model, value_method, options)
      term = term.gsub(/[_%]/) { |x| "\\#{x}" } # escape any _'s or %'s in the search term
      term = "#{term}%"
      term = "%#{term}" if options[:full_search]
      table_name = model.table_name
      lower = options[:case_sensitive] ? '' : 'LOWER'
      #["#{lower}(#{table_name}.#{value_method}) LIKE #{lower}(?)", term] # escape default: \ on postgres, mysql, sqlite

      # marretando a consulta na mão mesmo
      ["#{lower}(patients.name) LIKE #{lower}(?) OR #{lower}(lpad(patients.protocol_number, 5, 0)) LIKE #{lower}(?) OR #{lower}(patients.cpf) LIKE #{lower}(?) OR #{lower}(patients.email) LIKE #{lower}(?) OR #{lower}(patients.mobile) LIKE #{lower}(?)", term.tr(" ", "%"), term.tr(" ", "%"), term.tr(" ", "%"), term.tr(" ", "%"), term.tr(" ", "%")] # escape default: \ on postgres, mysql, sqlite

    end
    def autocomplete_build_json(results, value_method, label_method, options)
      results.collect do |result|
        data = HashWithIndifferentAccess.new(id: result.id,
                                             label: result.send(:protocol_and_name),
                                             value: result.send(:name))
        options[:additional_data].each do |method|
          data[method] = result.send(method)
        end if options[:additional_data]
        data
      end
    end
    ## fim da sobrescrita dos métodos da gem autocomplete

    # Use callbacks to share common setup or constraints between actions.
    def set_patient

      @patient = Patient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:protocol_number, :patient_since, :name, :birth, :age, :cpf, :gender, :etnia,
                                      :civil_status, :occupation, :scholarity, :zip, :address, :city, :district, :uf,
                                      :telephone, :mobile, :telephone_work, :mobile_work,
                                      :email, :indication_by, :health_insurance, :health_plan, :plan_validation,
                                      :plan_number, :created_at, :updated_at, :description, :national_identification,
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
