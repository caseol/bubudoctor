json.set! :data do
  json.array! @patients do |patient|
    json.partial! 'patients/patient', patient: patient

    json.url  "#{link_to 'Alterar', edit_patient_path(patient),  {:remote => true, data:{toggle: "modal", target: '#modal-window'}, class:"btn btn-primary"}}
              #{link_to 'Apagar', patient, {method: :delete, remote: true, class:"btn btn-danger", data: { confirm: 'Você tem certeza?' }} if current_user.admin?}
              #{link_to 'Histórico', historic_path(patient),  {class:"btn btn-info"} if current_user.admin? }
              ".html_safe
  end
end