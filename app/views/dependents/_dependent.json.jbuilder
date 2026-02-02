json.extract! dependent, :id, :last_name, :first_name, :middle_name, :birthdate, :gender, :relationship_id, :individual_id, :created_at, :updated_at
json.url dependent_url(dependent, format: :json)
