require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it do
      should validate_presence_of(:name)
      should validate_presence_of(:email)
      should validate_uniqueness_of(:email)
    end
  end
end
