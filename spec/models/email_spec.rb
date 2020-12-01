# frozen_string_literal: true

RSpec.describe VirtualMails::Email do
  subject { email }
  let(:email) { Email.new(mail) }
  let(:message_id) { 'message_id@something' }
  let(:from) { 'Yi-Cyuan<emn178@gmail.com>' }
  let(:to) { 'User1<user1@gmail.com>,User2<user2@gmail.com>' }
  let(:title) { 'Hello Users!' }
  let(:body) { 'Hello, This is plain body.' }
  let(:mail) {
    Mail.new(
      message_id: message_id,
      from: from,
      to: to,
      subject: title,
      body: body
    )
  }

  describe '#id' do
    its(:id) { should eq 'message_id' }
  end

  describe '#from' do
    its(:from) { should eq from }
  end

  describe '#to' do
    its(:to) { should eq 'User1 <user1@gmail.com>, ...1 more' }
  end

  describe '#list_to' do
    its(:list_to) { should eq to }
  end

  describe '#body' do
    context 'with plain' do
      its(:body) { should eq body }
    end

    context 'with html' do
      before {
        mail.html_part = Mail::Part.new do
          content_type 'text/html; charset=UTF-8'
          body '<h1>This is HTML</h1>'
        end
      }
      its(:body) { should eq '<h1>This is HTML</h1>' }
      it { expect(subject.send('plain')).to eq body }
    end
  end

  describe '#body_tag' do
    context 'with plain' do
      its(:body_tag) { should eq "<pre>#{body}</pre>" }
    end

    context 'with html' do
      before {
        mail.html_part = Mail::Part.new do
          content_type 'text/html; charset=UTF-8'
          body '<h1>This is HTML</h1>'
        end
      }
      its(:body_tag) { should eq '<iframe srcdoc="&lt;h1&gt;This is HTML&lt;/h1&gt;" onload="resizeIframe(this)"></iframe>' }
    end
  end

  describe '#raw' do
    its(:raw) { should include "From: Yi-Cyuan <emn178@gmail.com>\r\nTo: User1 <user1@gmail.com>, \r\n User2 <user2@gmail.com>\r\nMessage-ID: message_id@something\r\nSubject: Hello Users!\r\nMime-Version: 1.0\r\nContent-Type: text/plain;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\nHello, This is plain body." }
  end

  describe '.clear' do
    after { Email.clear }
    it { expect_any_instance_of(ActiveSupport::Cache::FileStore).to receive(:delete).with(VirtualMails::CACHE_KEY) }
  end

  describe '.all' do
    before { Email.clear }

    context 'without cache' do
      subject { Email.all }
      it { should eq [] }
    end

    context 'with cache' do
      subject { Email.all }
      let(:emails) { [email, email] }
      before { allow_any_instance_of(ActiveSupport::Cache::FileStore).to receive(:fetch).with(VirtualMails::CACHE_KEY).and_return(emails) }
      its(:length) { should eq 2 }
    end
  end

  describe '.find' do
    let(:message_id) { 'message_id' }
    let(:other) { Email.new(Mail.new(message_id: 'not@target')) }
    let(:emails) { [other, email] }
    before { allow(Email).to receive(:all).and_return(emails) }
    subject { Email.find('message_id') }
    its(:id) { should eq 'message_id' }
  end
end
