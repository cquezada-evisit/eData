module EdataEav
  class EdataPackSerializer < ActiveModel::Serializer
    attributes :id, :created_at, :updated_at
    has_many :edata_values
  end
end
