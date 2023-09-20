require 'rails_helper'

describe ItemSerializer do
  let(:item) { create(:item) }
  let(:serializer) { ItemSerializer.new(item).serializable_hash }

  it do
    expected_hash = {
      data: {
        attributes: {
          id: item.id,
          title: item.title,
          kwc: item.kwc,
          price: item.price,
          original_price_details: item.original_price_details,
          image_url: item.image_url
        },
        id: item.id.to_s,
        type: :item
      }
    }
    expect(serializer).to eq expected_hash
  end
end
