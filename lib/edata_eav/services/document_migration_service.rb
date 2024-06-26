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
      EdataEav.logger.info "Processing NoSQL Doc #{@document}"

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

    def process_section(section, edata_pack, parent_config_item = nil)
      section.each do |key, value|
        edata_definition, edata_config_item = find_or_create_definition_and_config_item(key, value, parent_config_item, edata_pack)

        EdataEav.logger.info "Processing #{key} EdataDefinition #{edata_definition.id}, Root? #{parent_config_item.nil?}"

        if value.is_a?(Hash)
          process_section(value, edata_pack, edata_config_item)
        elsif value.is_a?(Array)
          value.each do |item|
            if item.is_a?(Hash)
              process_section(item, edata_pack, edata_config_item)
            else
              create_value_record(edata_pack, edata_definition, item)
            end
          end
        else
          create_value_record(edata_pack, edata_definition, value)
        end
      end
    end

    def find_or_create_definition_and_config_item(name, value, parent_config_item, edata_pack)
      data_type = determine_data_type(value)
      edata_definition = EdataEav::EdataDefinition.find_or_create_by!(
        name: name,
        data_type: data_type,
        edata_pack_id: edata_pack.id
      )
      
      edata_config = find_or_create_config(edata_definition)

      edata_config_item = edata_config.edata_config_items.find_or_create_by!(
        edata_definition_id: edata_definition.id,
        parent_edata_config_item_id: parent_config_item&.id
      )

      [edata_definition, edata_config_item]
    end

    def find_or_create_config(edata_definition)
      edata_definition.edata_configs.find_or_create_by!(name: edata_definition.name)
    end

    def create_value_record(edata_pack, edata_definition, value)
      EdataEav::EdataValue.create!(
        edata_pack_id: edata_pack.id,
        edata_definition_id: edata_definition.id,
        value: determine_value_field(value),
        value_text: value.is_a?(String) ? value : nil,
        value_datetime: parse_datetime(value),
        value_json: value.is_a?(Hash) ? value.to_json : nil
      )
    end

    def determine_data_type(value)
      case value
      when Hash then 'json'
      when Array then 'array'
      when Integer then 'integer'
      when Float then 'float'
      when TrueClass, FalseClass then 'boolean'
      else 'string'
      end
    end

    def determine_value_field(value)
      value.is_a?(Hash) || value.is_a?(Array) ? nil : value
    end

    def parse_datetime(value)
      DateTime.parse(value) rescue nil if value.is_a?(String) && value =~ /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}.*$/
    end
  end
end
