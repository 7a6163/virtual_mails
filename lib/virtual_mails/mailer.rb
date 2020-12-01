# frozen_string_literal: true

module VirtualMails
  class Mailer
    attr_accessor :settings

    def initialize(settings)
      self.settings = settings
    end

    def deliver!(mail)
      mails = Email.all
      mails.unshift(Email.new(mail))
      Mailer.cache.write(CACHE_KEY, mails)
    end

    def self.cache
      @cache ||= ActiveSupport::Cache::FileStore.new('tmp/virtual_mails')
    end
  end
end
