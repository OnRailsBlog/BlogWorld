class ApplicationMailbox < ActionMailbox::Base
  routing /blog@/i => :post
end
