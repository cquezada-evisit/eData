require 'spec_helper'
require 'rails_helper'

require_relative '../../lib/edata_eav'
require_relative '../factories/edata_migration_statuses'
require_relative '../../lib/edata_eav/services/document_migration_service'
require_relative '../../lib/edata_eav/services/json_builder_service'

RSpec.describe EdataEav::JsonBuilderService, type: :service do
  let(:user_health_document) do
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

  let(:visit_health_document) do
    {
      questions: {},
      reason: {
        name: "reason",
        label: "Short reason for request",
        response: "Testt"
      },
      description: [
        {
          name: "Description of illness",
          label: "Description of illness",
          response: {
            response: "Test"
          }
        }
      ],
      meta: {
        reason: {
          name: {
            updated_at: 1592705866402,
            updated_by: 51131
          },
          label: {
            updated_at: 1592705866402,
            updated_by: 51131
          },
          response: {
            updated_at: 1592705866402,
            updated_by: 51131
          },
          updated_at: 1592705866402,
          updated_by: 51131
        },
        updated_at: 1592705866402,
        updated_by: 51131,
        description: {
          updated_at: 1592705866402,
          updated_by: 51131
        }
      }
    }
  end

  it 'builds the correct User Health Doc JSON structure' do
    recordable = instance_double('User', migration_status: nil, build_migration_status: build(:edata_migration_statuses))
    edata_pack_id = EdataEav::DocumentMigrationService.migrate(user_health_document, recordable)
    service = EdataEav::JsonBuilderService.new(edata_pack_id)
    json_structure = service.build_json

    EdataEav.logger.info "Json Data #{json_structure}"

    expected_structure = {
      insurance: {},
      phh: {
        allergies_general: [],
        allergies_medications: [],
        medications: [],
        conditions: [],
        procedures: [],
        family_history: [],
        questions: [],
        vitals: {
          height: 14,
          heightUnit: "in",
          weight: 3,
          weightUnit: "lb"
        }
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
    }.as_json

    expect(
      json_structure['meta']['phh']['vitals']['height']['updated_at'].to_s
    ).to eq(
      expected_structure['meta']['phh']['vitals']['height']['updated_at'].to_s
    )
  end

  it 'builds the correct Visit Health Doc JSON structure' do
    recordable = instance_double('Visit', migration_status: nil, build_migration_status: build(:edata_migration_statuses))
    edata_pack_id = EdataEav::DocumentMigrationService.migrate(visit_health_document, recordable)
    service = EdataEav::JsonBuilderService.new(edata_pack_id)
    json_structure = service.build_json

    EdataEav.logger.info "Json Data #{json_structure}"

    expected_structure = {
      questions: {},
      reason: {
        name: "reason",
        label: "Short reason for request",
        response: "Testt"
      },
      description: [
        {
          name: "Description of illness",
          label: "Description of illness",
          response: {
            response: "Test"
          }
        }
      ],
      meta: {
        reason: {
          name: {
            updated_at: 1592705866402,
            updated_by: 51131
          },
          label: {
            updated_at: 1592705866402,
            updated_by: 51131
          },
          response: {
            updated_at: 1592705866402,
            updated_by: 51131
          },
          updated_at: 1592705866402,
          updated_by: 51131
        },
        updated_at: 1592705866402,
        updated_by: 51131,
        description: {
          updated_at: 1592705866402,
          updated_by: 51131
        }
      }
    }.as_json

    expect(
      json_structure['reason']['name'].to_s
    ).to eq(
      expected_structure['reason']['name'].to_s
    )
  end
end
