RSpec.describe VirtualMails::Mailer do
  Email = VirtualMails::Email
  let(:mailer) { Mailer.new({}) }
  let(:mail) { Mail.new }

  describe "#deliver!" do
    subject { Email.all }
    before { 
      Email.clear
      mailer.deliver! mail 
    }
    its(:length) { should eq 1 }
  end
end
