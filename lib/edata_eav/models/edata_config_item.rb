module EdataEav
  class EdataConfigItem < EdataEav::Base
    self.table_name = 'edata_config_items'
    include UuidGenerator

    belongs_to :edata_config,
                class_name: 'EdataEav::EdataConfig',
                foreign_key: 'edata_config_id'

    belongs_to :edata_definition,
                class_name: 'EdataEav::EdataDefinition',
                foreign_key: 'edata_definition_id'

    belongs_to :parent_edata_config_item,
                class_name: 'EdataEav::EdataConfigItem',
                optional: true

    has_many :nested_config_items,
              class_name: 'EdataEav::EdataConfigItem',
              foreign_key: 'parent_edata_config_item_id',
              dependent: :destroy

    accepts_nested_attributes_for :nested_config_items

    validates :edata_definition_id, :edata_config_id, presence: true
  end
end
