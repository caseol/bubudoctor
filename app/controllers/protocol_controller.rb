class ProtocolController < ApplicationController

  def protocol
  end

  def historic
    # recupera histórico do paciente
    @patient = Patient.find(params[:id])

  end
end
