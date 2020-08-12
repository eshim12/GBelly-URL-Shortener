class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :password

  has_many :urls
end
