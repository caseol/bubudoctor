json.set! :data do
  json.array! @diseases do |disease|
    json.partial! 'diseases/disease', disease: disease
    json.url  "
              #{link_to 'Show', disease }
              #{link_to 'Edit', edit_disease_path(disease)}
              #{link_to 'Destroy', disease, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end