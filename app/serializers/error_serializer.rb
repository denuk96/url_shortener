class ErrorSerializer
  include JSONAPI::Serializer

  attribute :errors do |obj|
    obj.errors.as_json
  end
end
