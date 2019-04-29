json.set! :data do
  json.array! @patients do |patient|
    json.partial! 'patients/patient', patient: patient
    json.url  "
              #{link_to 'Show', patient }
              #{link_to 'Edit', edit_patient_path(patient)}
              #{link_to 'Destroy', patient, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end