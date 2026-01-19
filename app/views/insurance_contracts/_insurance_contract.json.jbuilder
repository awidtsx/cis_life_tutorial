json.extract! insurance_contract, :id, :rate_id, :insured_id, :insured_type, :age, :amount_covered, :premium, :effectivity, :expiry, :created_at, :updated_at
json.url insurance_contract_url(insurance_contract, format: :json)
