module EdataEav
  class EdataPack < EdataEav::Base
    self.table_name = 'edata_packs'
    include UuidGenerator

    has_many :edata_definitions,
              class_name: 'EdataEav::EdataDefinition',
              foreign_key: 'edata_pack_id',
              dependent: :destroy

    has_many :edata_values,
              class_name: 'EdataEav::EdataValue',
              foreign_key: 'edata_pack_id',
              dependent: :destroy
  end
end
