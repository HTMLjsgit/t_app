json.extract! real_comment, :id, :comment, :user_id, :real_id, :created_at, :updated_at
json.url real_comment_url(real_comment, format: :json)
