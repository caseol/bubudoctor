class ProtocolController < ApplicationController
  before_action :admin_only, :only=> [:historic]

  def protocol
  end

  def historic
    # recupera histórico do paciente
    @patient = Patient.find(params[:id])
  end
end
