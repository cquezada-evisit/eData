module EdataEav
  module HealthRecordable
    extend ActiveSupport::Concern

    included do
      has_one :migration_status, as: :recordable, class_name: 'EdataEav::MigrationStatus'
    end

    def health_doc
      return nil if migration_status.nil?

      if migration_status.migrated
        migration_status.document
      else
        vault_owner = is_a?(Visit) ? patient : self
        document = Vaults::EvaultWrapper::Client.get_document(vault_owner, migration_status.document_id)

        EdataEav::DocumentMigrationService.migrate(document, self)

        migration_status.reload.document
      end
    end
  end
end
