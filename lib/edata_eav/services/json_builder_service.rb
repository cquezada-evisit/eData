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
      root_definitions = @edata_pack.edata_definitions.where(parent_id: nil)
      process_definitions(root_definitions, result)
      result
    end

    private

    def process_definitions(definitions, result)
      definitions.each do |definition|
        children = definition.children

        if children.any?
          result[definition.name] = {}
          process_definitions(children, result[definition.name])
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
