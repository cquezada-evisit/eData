module EdataEav
  class MigrationStatus < EdataEav::Base
    self.table_name = 'edata_migration_statuses'
    belongs_to :recordable, polymorphic: true
    
    validates :migrated, inclusion: { in: [true, false] }
    validates :document, presence: true
  end
end
