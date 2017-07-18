json.extract! secret, :id, :url, :message, :password, :created_at, :updated_at
json.url secret_url(secret, format: :json)
