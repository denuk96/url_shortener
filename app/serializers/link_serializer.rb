class LinkSerializer
  include JSONAPI::Serializer

  attributes :view_count, :original_url

  attribute :short_url do |obj|
    "#{ENV["HOST"]}/#{obj.slug}"
  end
end
