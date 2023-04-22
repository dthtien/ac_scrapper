FactoryBot.define do
  factory :item do
    title { 'FUJITSU ASTG09KMTC' + rand(1..10).to_s }
    kwc { '2.5kW(C) / 3.2kW(H)' }
    price { '$989.00 ' }
    original_price_details { '$99999' }
  end
end
