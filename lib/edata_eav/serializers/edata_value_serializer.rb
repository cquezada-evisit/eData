module EdataEav
  class EdataValueSerializer < ActiveModel::Serializer
    attributes :value, :value_text, :value_datetime, :value_json, :created_at, :updated_at
    belongs_to :edata_definition
  end
end
