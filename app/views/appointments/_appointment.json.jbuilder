# json.extract! appointment, :id, :user_id, :patient_id, :appointment_date, :appointment_kind, :status, :obs, :created_at, :updated_at, :created_at, :updated_at
json.empty_collumn appointment.empty_collumn
json.name appointment.patient.name
json.mobile (appointment.patient.mobile || appointment.patient.telephone)
json.appointment_date appointment.appointment_date.strftime("%m/%d/%Y %H:%M")
json.appointment_kind Appointment.human_enum_name(:appointment_kinds, appointment.appointment_kind)
json.status Appointment.human_enum_name(:status_kinds, appointment.status)
json.health_insurance appointment.try(:patient).try(:health_insurance)
json.url appointment_url(appointment, format: :json)

