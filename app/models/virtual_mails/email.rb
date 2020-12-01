# frozen_string_literal: true

module VirtualMails
  class Email
    include ActionView::Helpers::TagHelper

    attr_accessor :message

    delegate :subject, :date, to: :message

    def initialize(message)
      @message = message
    end

    def id
      @message.message_id.split('@')[0]
    end

    def from
      @message.header.fields.find { |f| f.name == 'From' }.value
    end

    def to
      addresses = @message.header.fields.find { |f| f.name == 'To' }.address_list.addresses
      address = addresses[0].to_s
      count = addresses.length
      count > 1 ? address + ", ...#{count - 1} more" : address
    end

    def list_to
      @message.header.fields.find { |f| f.name == 'To' }.value
    end

    def body
      html || plain
    end

    def body_tag
      html_tag || plain_tag
    end

    def raw
      @message.to_s
    end

    def self.all
      VirtualMails::Mailer.cache.fetch(CACHE_KEY) do
        []
      end
    end

    def self.find(id)
      mail = all.find { |m| m.id == id }
      raise ActiveRecord::RecordNotFound if mail.nil?

      mail
    end

    def self.clear
      VirtualMails::Mailer.cache.delete(CACHE_KEY)
    end

    private

    def html
      if @message.html_part
        @message.html_part.body.decoded
      else
        @message.content_type =~ /html/ ? plain : nil
      end
    end

    def html_tag
      content = html
      content_tag :iframe, '', srcdoc: content, onload: 'resizeIframe(this)' unless content.nil?
    end

    def plain
      if @message.multipart?
        @message.text_part ? @message.text_part.body.decoded : nil
      else
        @message.body.decoded
      end
    end

    def plain_tag
      content = plain
      content_tag :pre, content unless content.nil?
    end
  end
end
