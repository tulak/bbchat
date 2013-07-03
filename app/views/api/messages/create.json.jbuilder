json.body @message.body
json.created_at l(@message.created_at, format: :long)
json.author @message.user.name