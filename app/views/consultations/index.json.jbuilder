json.set! :data do
  json.array! @consultations do |consultation|
    json.partial! 'consultations/consultation', consultation: consultation
    json.url  "
              #{link_to 'Show', consultation }
              #{link_to 'Edit', edit_consultation_path(consultation)}
              #{link_to 'Destroy', consultation, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end