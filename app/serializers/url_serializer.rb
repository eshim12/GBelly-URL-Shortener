class UrlSerializer < ActiveModel::Serializer
  attributes :id, :long_url, :slug, :shortened_url
end
