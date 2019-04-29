json.extract! appointment, :id, :user_id, :patient_id, :appointment_date, :appointment_kind, :status, :obs, :created_at, :updated_at, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
