module EdataEav
  class EdataValue < ActiveRecord::Base
    include UuidGenerator

    belongs_to :edata_pack
    belongs_to :edata_definition

    serialize :meta, JSON
  end
end
