module EdataEav
  class EdataValue < EdataEav::Base
    self.table_name = 'edata_values'
    include UuidGenerator

    belongs_to :edata_pack
    belongs_to :edata_definition
  end
end
