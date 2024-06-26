# spec/models/edata_eav/edata_pack_spec.rb
require 'rails_helper'

RSpec.describe EdataEav::EdataPack, type: :model do
  describe 'nested attributes' do
    it 'creates EdataPack with nested EdataDefinitions' do
      edata_pack_params = {
        edata_definitions_attributes: [
          {
            name: 'Example Definition 1',
            is_sensitive: false,
            data_type: 'string',
            label: 'Example Label 1'
          },
          {
            name: 'Example Definition 2',
            is_sensitive: true,
            data_type: 'integer',
            label: 'Example Label 2'
          }
        ]
      }

      expect {
        EdataEav::EdataPack.create!(edata_pack_params)
      }.to change(EdataEav::EdataPack, :count).by(1)
        .and change(EdataEav::EdataDefinition, :count).by(2)
    end

    it 'destroys nested EdataDefinitions when destroyed' do
      edata_pack = EdataEav::EdataPack.create!(
        edata_definitions_attributes: [
          {
            name: 'Example Definition 1',
            is_sensitive: false,
            data_type: 'string',
            label: 'Example Label 1'
          }
        ]
      )

      expect {
        edata_pack.destroy
      }.to change(EdataEav::EdataDefinition, :count).by(-1)
    end
  end
end
