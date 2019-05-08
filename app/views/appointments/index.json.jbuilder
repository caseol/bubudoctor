json.set! :data do
  json.array! @appointments do |appointment|
    json.partial! 'appointments/appointment', appointment: appointment
    json.url  "#{link_to 'Alterar', edit_appointment_path(appointment) ,  {:remote => true, class:"btn btn-primary", data:{toggle: "modal", target: '#modal-window'}}}
               #{link_to 'Apagar', appointment, method: :delete, class:"btn btn-danger", data: { confirm: 'Você tem certeza?' }}
               #{link_to 'Histórico', historic_path(appointment.patient),  {class:"btn btn-info"} if current_user.admin? }
              ".html_safe

  end
end