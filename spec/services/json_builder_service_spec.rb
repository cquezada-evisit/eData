require 'spec_helper'
require 'rails_helper'

require_relative '../../lib/edata_eav'
require_relative '../factories/edata_migration_statuses'
require_relative '../../lib/edata_eav/services/document_migration_service'
require_relative '../../lib/edata_eav/services/json_builder_service'

RSpec.describe EdataEav::JsonBuilderService, type: :service do
  let(:document) do
    {
      insurance: {},
      phh: {
        allergies_general: [],
        allergies_medications: [],
        medications: [],
        conditions: [],
        procedures: [],
        family_history: [],
        questions: [],
        vitals: { height: 14, heightUnit: "in", weight: 3, weightUnit: "lb" }
      },
      meta: {
        phh: {
          vitals: {
            height: { updated_at: 1666805414827, updated_by: 158629 },
            heightUnit: { updated_at: 1666805414827, updated_by: 158629 },
            weight: { updated_at: 1666805414827, updated_by: 158629 },
            weightUnit: { updated_at: 1666805414827, updated_by: 158629 },
            updated_at: 1666805414827,
            updated_by: 158629
          },
          updated_at: 1666805414827,
          updated_by: 158629
        },
        updated_at: 1666805414827,
        updated_by: 158629
      }
    }
  end

  let(:recordable) { instance_double('Recordable', migration_status: nil, build_migration_status: build(:edata_migration_statuses)) }
  let(:edata_pack) { EdataEav::DocumentMigrationService.migrate(document, recordable); EdataEav::EdataPack.last }

  it 'builds the correct JSON structure' do
    service = EdataEav::JsonBuilderService.new(edata_pack.id)
    json_structure = service.build_json

    expected_structure = {
      "insurance" => {},
      "phh" => {
        "allergies_general" => [],
        "allergies_medications" => [],
        "medications" => [],
        "conditions" => [],
        "procedures" => [],
        "family_history" => [],
        "questions" => [],
        "vitals" => {
          "height" => 14,
          "heightUnit" => "in",
          "weight" => 3,
          "weightUnit" => "lb"
        }
      },
      "meta" => {
        "phh" => {
          "vitals" => {
            "height" => { "updated_at" => 1666805414827, "updated_by" => 158629 },
            "heightUnit" => { "updated_at" => 1666805414827, "updated_by" => 158629 },
            "weight" => { "updated_at" => 1666805414827, "updated_by" => 158629 },
            "weightUnit" => { "updated_at" => 1666805414827, "updated_by" => 158629 },
            "updated_at" => 1666805414827,
            "updated_by" => 158629
          },
          "updated_at" => 1666805414827,
          "updated_by" => 158629
        },
        "updated_at" => 1666805414827,
        "updated_by" => 158629
      }
    }

    expect(
      json_structure['meta']['phh']['vitals']['height']['updated_at'].to_s
    ).to eq(
      expected_structure['meta']['phh']['vitals']['height']['updated_at'].to_s
    )
  end
end
