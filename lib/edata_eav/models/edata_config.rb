module EdataEav
  class EdataConfig < EdataEav::Base
    self.table_name = 'edata_configs'
    include UuidGenerator

    has_many :edata_config_items,
              class_name: 'EdataEav::EdataConfigItem',
              foreign_key: 'edata_config_id',
              dependent: :destroy

    validates :name, presence: true

    accepts_nested_attributes_for :edata_config_items, allow_destroy: true
  end
end
