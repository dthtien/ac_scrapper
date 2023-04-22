require 'rails_helper'

describe Items::RefreshesController, type: :controller do
  describe 'PUT #update' do
    let(:scraper_double) { instance_double(Scrapers::AirConditionersScraper, call: nil) }

    before do
      allow(Scrapers::AirConditionersScraper).to receive(:new).and_return(scraper_double)
      put :update
    end

    it 'renders items' do
      expect(Scrapers::AirConditionersScraper).to have_received(:new)
      expect(scraper_double).to have_received(:call)

      expect(response).to redirect_to(root_path)
    end
  end
end

