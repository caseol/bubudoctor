json.set! :data do
  json.array! @appointments do |appointment|
    json.partial! 'appointments/appointment', appointment: appointment
    json.url  "
              #{link_to 'Show', appointment }
              #{link_to 'Edit', edit_appointment_path(appointment)}
              #{link_to 'Destroy', appointment, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end