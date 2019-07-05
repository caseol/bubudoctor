json.set! :data do
  json.array! @exams do |exam|
    json.partial! 'exams/exam', exam: exam
    json.url  "
              #{link_to 'Show', exam }
              #{link_to 'Edit', edit_exam_path(exam)}
              #{link_to 'Destroy', exam, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end