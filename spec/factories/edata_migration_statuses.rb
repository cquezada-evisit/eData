FactoryBot.define do
  factory :edata_migration_statuses, class: 'EdataEav::MigrationStatus' do
    migrated { false }
    document { {} }
  end
end
