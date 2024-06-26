module EdataEav
  class EdataValue < EdataEav::Base
    self.table_name = 'edata_values'
    include UuidGenerator

    belongs_to :edata_pack,
                class_name: 'EdataEav::EdataPack'

    belongs_to :edata_definition,
                class_name: 'EdataEav::EdataDefinition'
  end
end
