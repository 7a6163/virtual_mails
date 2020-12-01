# frozen_string_literal: true

RSpec.describe VirtualMails::Mailer do
  let(:mailer) { Mailer.new({}) }
  let(:mail) { Mail.new }

  describe '#deliver!' do
    subject { VirtualMails::Email.all }
    before {
      VirtualMails::Email.clear
      mailer.deliver! mail
    }
    its(:length) { should eq 1 }
  end
end
