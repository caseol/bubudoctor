#json.extract! exam, :id, :patient_id, :title, :conclusion, :exam_table, :date_done, :created_at, :updated_at
json.id exam.id
json.patient_id exam.patient_id
json.title exam.title
json.conclusion exam.conclusion
json.date_done exam.date_done
#json.exam_table
file_array =[]
exam.exam_files.each_with_index do |upload, idx|
  file_array << link_to(upload.filename, rails_blob_path(upload), target: "_blank")
end
json.exam_files file_array
json.url exam_url(exam, format: :json)
