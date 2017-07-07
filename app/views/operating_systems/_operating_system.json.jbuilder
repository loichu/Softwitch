#json.extract! operating_system, :id, :created_at, :updated_at
json.operating_systems @operating_systems
json.url operating_system_url(operating_system, format: :json)
