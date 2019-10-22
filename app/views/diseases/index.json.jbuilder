json.set! :data do
  json.array! @diseases do |disease|
    json.partial! 'diseases/disease', disease: disease
    json.url  "#{link_to 'Alterar', edit_disease_path(disease), {:remote => true, data:{toggle: "modal", target: '#modal-patient'}, class:"btn btn-primary"}}
              #{link_to 'Apagar', disease_delete_associate_patient_path(disease_id: disease.id, patient_id: @patient.id), {method: :delete, remote: true, class:"btn btn-danger", data: { confirm: 'Você tem certeza?' }} if current_user.admin? and !@patient.blank?}
              ".html_safe
  end
end