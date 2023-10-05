require 'rails_helper'

RSpec.describe Quote, type: :model do
  context 'validations' do
    it do
      should validate_presence_of(:division)
      should validate_presence_of(:storey)
    end
  end

  context 'associations' do
    it { should belong_to(:user) }
  end
end
