module EdataEav
  class EdataDefinition < EdataEav::Base
    self.table_name = 'edata_definitions'
    include UuidGenerator

    belongs_to :edata_pack,
                class_name: 'EdataEav::EdataPack'

    has_many :edata_values,
              class_name: 'EdataEav::EdataValue',
              foreign_key: 'edata_definition_id',
              dependent: :destroy

    has_many :edata_config_items,
              class_name: 'EdataEav::EdataConfigItem',
              foreign_key: 'edata_definition_id',
              dependent: :destroy

    has_many :edata_configs,
              through: :edata_config_items,
              class_name: 'EdataEav::EdataConfig'

    accepts_nested_attributes_for :edata_config_items, allow_destroy: true
  end
end
