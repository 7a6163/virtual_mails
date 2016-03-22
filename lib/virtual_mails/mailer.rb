module VirtualMails
  class Mailer
    attr_accessor :settings

    def initialize(settings)
      self.settings = settings
    end

    def deliver!(mail)
      mails = Email.all
      mails.unshift(Email.new(mail))
      Rails.cache.write(CacheKey, mails)
    end
  end
end
