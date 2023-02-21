class CommentMailbox < ApplicationMailbox
  def process
    Comment.create author: mail["from"].to_s, content: mail.body.to_s, post: post
  end

  def post
    return @post unless @post.nil?
    email = mail.recipients.reject { |address| address.blank? }.first
    match = email.match(/^comment\+(.*)@/i)
    token = match[1]

    begin
      if token
        @post = Post.find_by_id(token)
      else
        bounced!
      end
    rescue RecordNotFound
      bounced!
    end
  end
end
