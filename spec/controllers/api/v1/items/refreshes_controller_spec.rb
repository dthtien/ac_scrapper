# frozen-string-literal: true
require 'rails_helper'

describe Api::V1::Items::RefreshesController, type: :controller do
  describe 'PUT #update' do
    it do
      allow(Scrapers::AirConditionersScraper).to receive(:new).and_return(double(call: true))
      put :update

      expect(response).to have_http_status 200
      expect(Scrapers::AirConditionersScraper).to have_received(:new)
    end
  end
end

