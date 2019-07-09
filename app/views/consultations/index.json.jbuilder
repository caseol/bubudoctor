json.set! :data do
  json.array! @consultations do |consultation|
    json.partial! 'consultations/consultation', consultation: consultation
    json.url  "
              #{link_to 'Mostrar', consultation,  {remote: true, class:"btn btn-info"} }
              #{link_to 'Alterar', edit_consultation_path(consultation),  {remote: true, class:"btn btn-primary"}}
              #{link_to 'Apagar', consultation, {remote: true, method: :delete, class:"btn btn-danger", data: { confirm: 'Você tem certeza que deseja apagar a consulta?' }}}
              "
  end
end