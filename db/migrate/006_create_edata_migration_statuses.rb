class CreateEdataMigrationStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :edata_migration_statuses do |t|
      t.string :recordable_type
      t.string :recordable_id
      t.boolean :migrated, default: false
      t.json :document

      t.timestamps
    end

    add_index :edata_migration_statuses, [:recordable_type, :recordable_id], name: 'index_migration_statuses_on_recordable'
  end
end
