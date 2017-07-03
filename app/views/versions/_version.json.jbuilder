json.(version, :id, :name, :date, :distrilog, :install_link, :website, :updated_at)
json.operating_systems version.operating_systems do |os|
  json.name = os.name
end

json.url version_url(version, format: :json)