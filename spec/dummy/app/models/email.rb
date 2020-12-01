# frozen_string_literal: true

class Email
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :from, :to, :body, :subject

  validates_presence_of :from, :to, :body, :subject

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def to_h
    { to: to, from: from, body: body, subject: subject }
  end
end
