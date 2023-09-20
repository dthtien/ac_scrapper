FactoryBot.define do
  factory :item do
    title { 'FUJITSU ASTG09KMTC' + rand(1..10).to_s }
    kwc { '2.5kW(C) / 3.2kW(H)' }
    price { '$989.00 ' }
    original_price_details { '$99999' }
    image_url { 'https://www.airwaresales.com.au/wp-content/uploads/bfi_thumb/kelvinator-ksv-models-ocbwsu14smbcxmzmtvsdqi0n5mhs4qe23b1ku2ayvk.jpg' }
  end
end
