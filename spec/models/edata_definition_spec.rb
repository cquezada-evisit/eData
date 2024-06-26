require 'rails_helper'

RSpec.describe EdataEav::EdataDefinition, type: :model do
  it { should belong_to(:edata_pack) }
  it { should have_many(:edata_values).dependent(:destroy) }
  it { should have_many(:edata_config_items).dependent(:destroy) }
  it { should accept_nested_attributes_for(:edata_config_items) }
end
