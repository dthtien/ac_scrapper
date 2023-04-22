# frozen-string-literal: true
require 'rails_helper'

describe ItemsController, type: :controller do
  describe 'GET #index' do
    let(:items) { create_list(:item, 3) }

    it 'renders items' do
      expect(Item).to receive_message_chain(:search, :order).and_return(items)
      get :index

      expect(response).to have_http_status 200
    end
  end
end
