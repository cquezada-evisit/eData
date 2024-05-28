module EdataEav
  class EdataDefinition < EdataEav::Base
    self.table_name = 'edata_definitions'
    include UuidGenerator

    belongs_to :edata_pack,
                class_name: 'EdataEav::EdataPack'

    belongs_to :parent,
                class_name: 'EdataEav::EdataDefinition',
                optional: true

    has_many :children,
              class_name: 'EdataEav::EdataDefinition',
              foreign_key: 'parent_id',
              dependent: :destroy

    has_many :edata_values,
              class_name: 'EdataEav::EdataValue',
              foreign_key: 'edata_definition_id',
              dependent: :destroy
  end
end
