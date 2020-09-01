
json.extract! patient, :id, :protocol_number, :protocol_and_name, :patient_since, :name, :birth, :age, :cpf, :gender, :etnia, :civil_status, :occupation, :scholarity, :zip, :address, :city, :district, :uf, :telephone, :mobile, :email, :indication_by, :health_insurance, :health_plan, :plan_validation, :plan_number, :created_at, :updated_at, :created_at, :updated_at
json.url patient_url(patient, format: :json)
