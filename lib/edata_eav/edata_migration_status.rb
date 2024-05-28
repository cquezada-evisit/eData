module EdataEav
  class MigrationStatus < ActiveRecord::Base
    belongs_to :recordable, polymorphic: true
  end
end
