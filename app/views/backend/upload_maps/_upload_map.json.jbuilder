json.extract! upload_map, :id, :map_id, :user_id, :name, :file, :size, :content_type, :created_at, :updated_at
json.url upload_map_url(upload_map, format: :json)