module EdataEav
  class EdataDefinition < ActiveRecord::Base
    include UuidGenerator

    has_many :children,
              class_name: 'EdataDefinition',
              foreign_key: 'parent_id'

    belongs_to :parent,
                class_name: 'EdataDefinition',
                optional: true

    has_many :edata_values
  end
end
