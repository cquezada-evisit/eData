module EdataEav
  class EdataPack < ActiveRecord::Base
    include UuidGenerator

    has_many :edata_values
  end
end
