# frozen-string-literal: true
require 'rails_helper'

describe Item do
  describe '.search' do
    let!(:item) { create(:item, title: 'test') }
    let!(:items) { create_list(:item, 3) }

    subject { Item.search('test') }

    it { is_expected.to eq [item] }
  end
end

