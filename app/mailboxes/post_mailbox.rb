class PostMailbox < ApplicationMailbox
  def process
    post = Post.new title: mail["subject"].to_s, author: mail["from"].to_s
    post.content = if mail.html_part
      mail.html_part.decoded
    elsif mail.text_part
      mail.text_part.decoded
    else
      mail.decoded
    end
    post.save
  end
end
