json.extract! user, :id, :phone, :fname, :lname, :created_at, :updated_at
json.url user_url(user, format: :json)
