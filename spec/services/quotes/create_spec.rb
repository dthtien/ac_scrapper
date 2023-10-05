# frozen-string-literal: true
require 'rails_helper'

describe Quotes::Create, type: :service do
  context '#call' do
    let(:service) do
      described_class.new(params)
    end
    let(:params) do
      {
        email: email,
        name: 'sample',
        phone: '1234567890',
        address: 'sample address',
        division: 'electrical',
        storey: 'single'
      }
    end

    context 'when user is not existed yet' do
      let(:email) { 'sample@email.com' }

      context 'when params are valid' do
        before { service.call }

        it do
          expect(Quote.exists?(params.slice(:address, :division, :storey))).to be_truthy
          expect(User.exists?(email: email)).to be_truthy
          expect(service.success?).to be_truthy
        end
      end

      context 'when params are invalid' do
        let(:params) do
          {
            email: email,
            name: '',
            phone: '1234567890',
            address: 'sample address',
            division: 'electrical',
            storey: 'single'
          }
        end

        before { service.call }

        it do
          expect(service.success?).to be_falsey
          expect(service.errors).to include("Validation failed: Name can't be blank")
        end
      end
    end

    context 'when user is existed' do
      let(:email) { 'sample@email.com' }
      let!(:user) { create(:user, email: email) }

      before do
        service.call
        user.reload
      end

      it do
        expect(user.quotes.exists?(params.slice(:address, :division, :storey))).to be_truthy
        expect(service.success?).to be_truthy
        expect(user.name).to eq(params[:name])
        expect(user.phone).to eq(params[:phone])
      end
    end
  end
end
