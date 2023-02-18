json.extract! comment, :id, :author, :content, :post_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
json.content comment.content.to_s
