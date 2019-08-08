json.extract! patient, :id, :protocol_number, :patient_since, :name, :birth, :age, :cpf, :gender, :etnia, :civil_status, :occupation, :scholarity, :zip, :address, :city, :uf, :telephone, :mobile, :email, :indication_by, :health_plan, :plan_validation, :plan_number, :created_at, :updated_at, :created_at, :updated_at
json.url patient_url(patient, format: :json)
