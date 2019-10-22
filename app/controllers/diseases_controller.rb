class DiseasesController < ApplicationController
  before_action :set_disease, only: [:show, :edit, :update, :destroy]
  autocomplete :disease, :code, :display_value => :funky_method, additional_data: [:name, :description, :icd], order: "diseases.name ASC"

  # GET /diseases
  # GET /diseases.json
  def index
    if params[:patient_id]
      @patient = Patient.find(params[:patient_id])
      @diseases = @patient.diseases
    else
      @patient = nil
      @diseases = Disease.all
    end
    respond_to :html, :json, :js
  end

  # GET /diseases/1
  # GET /diseases/1.json
  def show
  end

  # GET /diseases/new
  def new
    @disease = Disease.new
  end

  # GET /diseases/1/edit
  def edit
    respond_to :html, :js#, layout: false
  end

  # POST /diseases
  # POST /diseases.json
  def create
    @disease = Disease.new(disease_params)

    respond_to do |format|
      if @disease.save
        format.html { redirect_to @disease, notice: 'Disease was successfully created.' }
        format.json { render :show, status: :created, location: @disease }
      else
        format.html { render :new }
        format.json { render json: @disease.errors, status: :unprocessable_entity }
      end
    end
  end

  def new_and_associate_patient
    disease_code = params["search_disease"]
    patient_id = params["patient_id"]
    patient = Patient.find_by_id(patient_id)

    @disease = Disease.new(code: disease_code)
    @disease.patients << patient

    respond_to do |format|
      if @disease.save
        format.js { flash.now[:notice] = "Nova Doença/Problema (#{@disease.code}) criada e associada ao paciente #{patient.name} com sucesso."}
      else
        format.js { flash.now[:notice] = @consultation.errors }
      end
    end
  end

  # PATCH/PUT /diseases/1
  # PATCH/PUT /diseases/1.json
  def update
    respond_to do |format|
      if @disease.update(disease_params)
        format.html { redirect_to @disease, notice: 'Descrição da Doença/Problema alterada com sucesso.' }
        format.js { flash.now[:notice] = 'Descrição da Doença/Problema alterada com sucesso.'}
        format.json { render :show, status: :ok, location: @disease }
      else
        format.html { render :edit }
        format.js { render :edit, flash.now[:notice] = @consultation.errors }
        format.json { render json: @disease.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diseases/1
  # DELETE /diseases/1.json
  def destroy
    @disease.destroy
    respond_to do |format|
      format.html { redirect_to diseases_url, notice: 'Doença/Problema removida com sucesso.' }
      format.js   { flash.now[:notice] = 'Doença/Problema removida com sucesso.'}
      format.json { head :no_content }
    end
  end

  def associate_patient
    disease_id = params["disease_id"]
    patient_id = params["patient_id"]
    patient = Patient.find_by_id(patient_id)
    disease = Disease.find_by_id(disease_id)

    patient.diseases << disease
    patient.save
    respond_to do |format|
      format.js   { flash.now[:notice] = "#{disease.code} associado ao paciente #{patient.name} com sucesso."}
    end
  end

  def delete_associate_patient
    disease_id = params["disease_id"]
    patient_id = params["patient_id"]
    patient = Patient.find_by_id(patient_id)
    disease = Disease.find_by_id(disease_id)

    patient.diseases.delete(disease)
    patient.save
    respond_to do |format|
      #format.html { redirect_to diseases_url, notice: 'Doença/Problema não está mais relacionado com o paciente' }
      format.json { head :no_content }
      format.js   { flash.now[:notice] = "#{disease.code} desassociado do paciente #{patient.name} com sucesso."}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_disease
      @disease = Disease.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def disease_params
      params.require(:disease).permit(:code, :name, :description, :icd)
    end
end
