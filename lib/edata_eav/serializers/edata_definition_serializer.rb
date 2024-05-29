module EdataEav
  class EdataDefinitionSerializer < ActiveModel::Serializer
    attributes :name, :is_sensitive, :data_type, :label, :parent_id, :created_at, :updated_at
    has_many :children
  end
end
