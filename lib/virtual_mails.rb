# frozen_string_literal: true

require 'virtual_mails/version'
require 'virtual_mails/engine'
require 'virtual_mails/mailer'

module VirtualMails
  CACHE_KEY = 'virtual_mails'

  ActionMailer::Base.add_delivery_method :virtual, Mailer
end
