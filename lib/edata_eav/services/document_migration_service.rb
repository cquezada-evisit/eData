module EdataEav
  class DocumentMigrationService
    class MigrationError < StandardError; end

    def self.migrate(document, recordable)
      new(document, recordable).migrate
    end

    def initialize(document, recordable)
      @document = document.deep_symbolize_keys
      @recordable = recordable
      @migration_status = recordable.migration_status || recordable.build_migration_status
    end

    def migrate
      ActiveRecord::Base.transaction do
        @edata_pack = EdataEav::EdataPack.create!
        process_section(@document, @edata_pack)
        @migration_status.update!(document: @document, migrated: true)
      end

      @edata_pack.id
    rescue StandardError => e
      raise MigrationError, "Migration failed: #{e.message}"
    end

    private

    def process_section(section, edata_pack, parent_definition = nil)
      section.each do |key, value|
        edata_definition = find_or_create_definition(key, parent_definition, value)
        EdataEav.logger.info "Processing EdataDefinition #{edata_definition.id}, Root? #{edata_definition.parent.present?}"

        if value.is_a?(Hash)
          process_section(value, edata_pack, edata_definition)
        elsif value.is_a?(Array)
          value.each do |item|
            if item.is_a?(Hash)
              process_section(item, edata_pack, edata_definition)
            else
              create_value_record(edata_pack, edata_definition, item)
            end
          end
        else
          create_value_record(edata_pack, edata_definition, value)
        end
      end
    end

    def find_or_create_definition(name, parent_definition, value)
      EdataEav::EdataDefinition.find_or_create_by!(
        name: name.to_s,
        data_type: value.class,
        parent: parent_definition,
        edata_pack: @edata_pack
      )
    end

    def create_value_record(edata_pack, edata_definition, value)
      EdataEav::EdataValue.create!(
        edata_pack: edata_pack,
        edata_definition: edata_definition,
        value: value,
        value_text: value.is_a?(String) ? value : nil,
        value_datetime: parse_datetime(value),
        value_json: value.is_a?(Hash) ? value : nil
      )
    end

    def parse_datetime(value)
      DateTime.parse(value) rescue nil if value.is_a?(String) && value =~ /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}.*$/
    end
  end
end
