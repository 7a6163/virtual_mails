# frozen_string_literal: true

RSpec.describe VirtualMails::EmailsController, type: :controller do
  routes { VirtualMails::Engine.routes }

  subject { response }

  describe '#index' do
    before do
      allow(Email).to receive(:all).and_return([1, 2])
      get :index
    end
    it { expect(assigns(:emails)).to eq([2, 1]) }
  end

  describe '#raw' do
    let(:email) { OpenStruct.new(raw: 'raw') }
    after do
      get :raw, id: '1'
    end
    it { expect(Email).to receive(:find).with('1').and_return(email) }
  end

  describe '#clear' do
    after do
      delete :clear
    end
    it { expect(Email).to receive(:clear) }
  end
end
