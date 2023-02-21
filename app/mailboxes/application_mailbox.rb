class ApplicationMailbox < ActionMailbox::Base
  routing(/blog@/i => :post)
  routing(/^comment\+\d+@/i => :comment)
end
