# frozen-string-literal: true

require 'rails_helper'

describe Api::V1::QuotesController, type: :controller do
  describe 'POST #create' do
    let(:params) do
      {
        email: 'sample@email.com',
        name: 'sample',
        phone: '1234567890',
        address: 'sample address',
        division: 'electrical',
        storey: 'single'
      }
    end

    context 'when create fail' do
      let(:service) do
        double(call: true, success?: false, errors: ['Validation failed: Name can\'t be blank'])
      end

      before do
        allow(Quotes::Create).to receive(:new).and_return(service)
        post :create, params: params
      end

      it do
        expect(service).to have_received(:call)
        expect(response).to have_http_status 422
        expect(JSON.parse(response.body)['errors']).to eq 'Validation failed: Name can\'t be blank'
      end
    end

    context 'when create success' do
      let(:quote) { create(:quote) }
      let(:service) do
        instance_double(Quotes::Create, call: true, success?: true, quote: quote)
      end

      before do
        allow(Quotes::Create).to receive(:new).and_return(service)
        post :create, params: params
      end

      it do
        expect(service).to have_received(:call)
        json_body = JSON.parse response.body
        expect(response).to have_http_status 200
        expect(json_body['data']['id']).to eq quote.id.to_s
      end
    end
  end
end
