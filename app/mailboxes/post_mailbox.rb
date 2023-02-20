class PostMailbox < ApplicationMailbox
  def process
    Post.create title: mail["subject"].to_s, author: mail["from"].to_s, content: mail.body.to_s
  end
end
