# frozen-string-literal: true
require 'rails_helper'

describe ItemsController, type: :controller do
  describe 'GET #index' do
    let(:items) { create_list(:item, 3) }

    before do
      allow(Item).to receive(:order).and_return(items)
    end

    it 'renders items' do
      get :index

      expect(Item).to have_received(:order)
      expect(response).to have_http_status 200
    end
  end
end
