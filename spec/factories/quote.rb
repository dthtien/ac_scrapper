# frozen-string-literal: true

FactoryBot.define do
  factory :quote do
    user
    division { 'electrical' }
    storey { 'single' }
    address { Faker::Address.street_address }
  end
end
