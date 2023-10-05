class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :email, :name, :phone
end
