class QuoteSerializer
  include JSONAPI::Serializer

  belongs_to :user

  attributes :id, :address, :division, :storey
end
