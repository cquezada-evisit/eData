require 'spec_helper'
require 'rails_helper'

require_relative '../../lib/edata_eav'
require_relative '../factories/edata_migration_statuses'
require_relative '../../lib/edata_eav/services/document_migration_service'


class VisitRecordable
  attr_accessor :migration_status

  def initialize
    @migration_status = nil
  end

  def build_migration_status
    FactoryBot.build(:edata_migration_statuses)
  end
end

RSpec.describe EdataEav::DocumentMigrationService do
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

  let(:recordable) { VisitRecordable.new }

  describe '.migrate' do
    it 'migrates the document to SQL' do
      service = EdataEav::DocumentMigrationService.new(document, recordable)

      expect { service.migrate }.to change { EdataEav::EdataPack.count }.by(1)
                                 .and change { EdataEav::EdataDefinition.count }.by_at_least(1)
                                 .and change { EdataEav::EdataValue.count }.by_at_least(1)
    end
  end
end
