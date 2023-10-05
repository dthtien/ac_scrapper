require 'rails_helper'

describe UserSerializer, type: :serializer do
  let(:user) { create(:user) }
  subject { described_class.new(user).serializable_hash }

  it do
    expected_hash = {
      data: {
        id: user.id.to_s,
        type: :user,
        attributes: {
          id: user.id,
          email: user.email,
          name: user.name,
          phone: user.phone
        }
      }
    }

    expect(subject).to eq expected_hash
  end
end
