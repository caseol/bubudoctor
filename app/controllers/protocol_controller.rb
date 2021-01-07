class ProtocolController < ApplicationController
  before_action :admin_only, :only=> [:historic]

  def protocol
    @today = Time.now
  end

  def search
    @today = Time.now
  end

  def historic
    # recupera histórico do paciente
    @patient = Patient.find(params[:id])
    if @patient.protocol_number.blank?
      last_protocol_number = Patient.maximum(:protocol_number)
      @patient.protocol_number = last_protocol_number + 1
    end
  end
end
