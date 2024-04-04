require 'rails_helper'

describe AirWareSalesAdapter do
  let(:service) { AirWareSalesAdapter.new }

  describe '#get_items' do
    it do
      VCR.use_cassette('adapters/air_ware_sales/get_items_success', match_requests_on: %i[method uri]) do
        result = service.get_items('https://www.airwaresales.com.au/shop/?pwb-brand=fujitsu')
        expect(result.css('.product')).to be_present
      end
    end
  end

  xdescribe '#login' do
    it do
      expect_any_instance_of(Mechanize).to receive(:get).and_call_original
      expect_any_instance_of(Mechanize).to receive(:submit).and_call_original
      VCR.use_cassette('adapters/air_ware_sales/login_success', match_requests_on: %i[method uri]) do
        service.login
        expect(service.send(:agent).current_page.uri.to_s).to eq('https://www.airwaresales.com.au/shop/')
      end
    end
  end
end
