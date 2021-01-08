# json.extract! appointment, :id, :user_id, :patient_id, :appointment_date, :appointment_kind, :status, :obs, :created_at, :updated_at, :created_at, :updated_at
#json.empty_collumn appointment.empty_collumn
json.name appointment.try(:patient).try(:protocol_and_name)
json.mobile (appointment.try(:patient).try(:mobile) || appointment.try(:patient).try(:telephone))
json.appointment_date appointment.try(:appointment_date).try(:strftime, "%m/%d/%Y %H:%M")
json.appointment_kind Appointment.human_enum_name(:appointment_kinds, appointment.appointment_kind)
json.status Appointment.human_enum_name(:status_kinds, appointment.status)
json.last_appointment appointment.try(:patient).try(:last_appointment).try(:strftime, "%m/%d/%Y %H:%M")
json.health_insurance appointment.try(:patient).try(:health_insurance)
#json.url appointment_url(appointment, remote: true, format: :js)

