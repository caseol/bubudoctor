json.extract! disease, :id, :code, :name, :description, :icd, :created_at, :updated_at
json.url disease_url(disease, format: :json)
