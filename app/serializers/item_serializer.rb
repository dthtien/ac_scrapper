class ItemSerializer
  include JSONAPI::Serializer

  attributes :id, :title, :kwc, :price, :original_price_details
end
