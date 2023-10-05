require 'rails_helper'

describe QuoteSerializer do
  let(:quote) { create(:quote) }
  let(:serializer) { described_class.new(quote).serializable_hash }

  it do
    expected_hash = {
      data: {
        attributes: {
          id: quote.id,
          address: quote.address,
          division: quote.division,
          storey: quote.storey
        },
        id: quote.id.to_s,
        type: :quote,
        relationships: {
          user: {
            data: {
              id: quote.user.id.to_s,
              type: :user
            }
          }
        }
      }
    }
    expect(serializer).to eq expected_hash
  end
end
