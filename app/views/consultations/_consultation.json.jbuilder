#json.extract! consultation, :id, :patient_id, :date_done, :biometric_exam, :thoracil_exam, :abdominal_exam, :members, :diagnostic_hypothesis, :conduct_adopt, :created_at, :updated_at, :consultation_files
#
json.date_done consultation.date_done.strftime("%Y/%m/%d")
file_array =[]
consultation.consultation_files.each_with_index do |upload, idx|
  if upload.variable?
    file_array << link_to(image_tag(upload.variant(resize: "300x300"), class: 'd-block w-100'), upload, target: "_blank")
  elsif upload.previewable?
    file_array << link_to(image_tag(upload.preview(resize: "300x300"), class: 'd-block w-100'), rails_blob_path(upload), target: "_blank")
  elsif upload.image?
    file_array << link_to(image_tag(upload, width: 300, class: 'd-block w-100'), upload, target: "_blank")
  else
    file_array << link_to(upload.filename, rails_blob_path(upload, disposition: :attachment), class: 'd-block w-100', target: "_blank")
  end
end
json.consultation_files file_array
json.url consultation_url(consultation, format: :json)
