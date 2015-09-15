require "virtual_mails/engine"
require "virtual_mails/mailer"

module VirtualMails
  CacheKey = 'virtual_mails'

  ActionMailer::Base.add_delivery_method :virtual, Mailer
end
