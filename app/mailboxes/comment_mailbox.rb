class CommentMailbox < ApplicationMailbox
  def process
    comment = Comment.new author: mail["from"].to_s, post: post
    comment.content = if mail.html_part
      mail.html_part.decoded
    elsif mail.text_part
      mail.text_part.decoded
    else
      mail.decoded
    end
    comment.save
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
