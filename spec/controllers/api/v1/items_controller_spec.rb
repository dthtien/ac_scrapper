# frozen-string-literal: true
require 'rails_helper'

describe Api::V1::ItemsController, type: :controller do
  describe 'GET #index' do
    let(:items) { create_list(:item, 3) }

    it 'renders items' do
      expect(Item).to receive_message_chain(:search, :order).and_return(items)
      get :index

      expect(response).to have_http_status 200
      json_response = JSON.parse(response.body)
      items = json_response['data']
      last_updated_at = json_response['meta']['last_updated_at']
      expect(items.size).to eq 3
      expect(last_updated_at).to be_present
    end
  end

  describe 'GET #show' do
    let(:item) { create(:item) }

    context 'when item exists' do
      before { get :show, params: { id: item.id } }
      it do
        expect(response).to have_http_status 200
        json_response = JSON.parse(response.body)
        expect(json_response['data']['id'].to_i).to eq item.id
      end
    end

    context 'when item does not exist' do
      before { get :show, params: { id: 0 } }
      it do
        expect(response).to have_http_status 404
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq 'Item not found'
      end
    end
  end
end
