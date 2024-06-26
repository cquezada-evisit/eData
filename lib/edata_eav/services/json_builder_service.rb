require 'oj'

module EdataEav
  class JsonBuilderService
    def initialize(edata_pack_id)
      @edata_pack = EdataEav::EdataPack.find(edata_pack_id)
      @edata_values = @edata_pack.edata_values.includes(:edata_definition)
    end

    def build_json
      EdataEav.logger.info "Building EdataPack #{@edata_pack.id} JSON structure from SQL..."

      result = {}
      root_config_items = EdataEav::EdataConfigItem.joins(:edata_definition)
                             .where(edata_definitions: { edata_pack_id: @edata_pack.id }, parent_edata_config_item_id: nil)
      process_config_items(root_config_items, result)
      Oj.dump(result, mode: :compat) # Using Oj to generate JSON string for the result
    end

    private

    def process_config_items(config_items, result)
      config_items.each do |config_item|
        definition = config_item.edata_definition
        children = config_item.children

        if children.any?
          result[definition.name] = {}
          process_config_items(children, result[definition.name])
        else
          values = definition.edata_values.where(edata_pack: @edata_pack)
          if values.size == 1
            result[definition.name] = extract_value(values.first)
          else
            result[definition.name] = values.map { |value| extract_value(value) }
          end
        end
      end
    end

    def extract_value(value_record)
      if value_record.value_json.present?
        value_record.value_json
      elsif value_record.value_text.present?
        value_record.value_text
      elsif value_record.value_datetime.present?
        value_record.value_datetime.iso8601
      else
        value_record.value
      end
    end
  end
end
