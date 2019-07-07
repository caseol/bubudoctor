class ExamsController < ApplicationController
  before_action :set_exam, only: [:show, :edit, :update, :destroy]

  # GET /exams
  # GET /exams.json
  def index
    if params[:patient_id]
      @exams = Exam.where(patient_id: params[:patient_id]).all
      @patient = Patient.find(params[:patient_id])
    else
      @exams = Exam.all
    end
    respond_to :html, :json, :js
  end

  # GET /exams/1
  # GET /exams/1.json
  def show
    respond_to :html, :json, :js
  end

  # GET /exams/new
  def new
    if params[:patient_id]
      @patient = Patient.find(params[:patient_id])
      @exam = Exam.new(patient_id: @patient.id)
    else
      @exam = Exam.new()
    end
    respond_to :html, :json, :js
  end

  # GET /exams/1/edit
  def edit
    respond_to :html, :json, :js
  end

  # POST /exams
  # POST /exams.json
  def create
    _exam_table = exam_params["exam_table"]
    _exam_params = exam_params.except('exam_table')

    @exam = Exam.new(_exam_params)
    @exam.exam_table = eval(_exam_table)

    respond_to do |format|
      if @exam.save
        format.html { redirect_to @exam, notice: 'Exame incluído com sucesso!' }
        format.js { flash.now[:notice] = 'Exame incluído com sucesso!'}
        format.json { render :show, status: :created, location: @exam }
      else
        format.html { render :new }
        format.js { render :new }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exams/1
  # PATCH/PUT /exams/1.json
  def update
    respond_to do |format|
      _exam_table = exam_params["exam_table"]
      _exam_params = exam_params.except('exam_table')

      if @exam.update(_exam_params)
        @exam.exam_table = eval(_exam_table)
        @exam.save
        format.html { redirect_to @exam, notice: 'Exame atualizado com sucesso!' }
        format.js { flash.now[:notice] = 'Exame atualizado com sucesso!'}
        format.json { render :show, status: :ok, location: @exam }
      else
        format.html { render :edit }
        format.js { render :edit }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exams/1
  # DELETE /exams/1.json
  def destroy
    @exam.destroy
    respond_to do |format|
      format.html { redirect_to exams_url, notice: 'Exame removido com sucesso!' }
      format.js   { flash.now[:notice] = 'Exame removido com sucesso!'}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam
      @exam = Exam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exam_params
      params.require(:exam).permit(:patient_id, :title, :conclusion, :exam_table, :date_done, exam_files: [])
    end
end
