json.set! :data do
  json.array! @exams do |exam|
    json.partial! 'exams/exam', exam: exam
    json.url  "
              #{link_to 'Mostrar', exam,{:remote => true, class:"btn btn-info", data:{toggle: "modal", target: '#modal-exames'}}}
              #{link_to 'Alterar', edit_exam_path(exam), {:remote => true, class:"btn btn-primary", data:{toggle: "modal", target: '#modal-exames'}}}
              #{link_to 'Apagar', exam, method: :delete, class:"btn btn-danger", data: { confirm: 'Você tem certeza?' }}
              "
  end
end