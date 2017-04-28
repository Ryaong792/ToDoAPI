class ListSerializer < ActiveModel::Serializer
  attributes :id, :name, :completed
  has_one :user
end
