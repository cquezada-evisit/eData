require 'rails_helper'

RSpec.describe EdataEav::EdataConfigItem, type: :model do
  it { should belong_to(:edata_definition) }
  it { should belong_to(:edata_config) }
  it { should belong_to(:parent_edata_config_item).class_name('EdataEav::EdataConfigItem').optional }
  it { should have_many(:nested_config_items).dependent(:destroy) }
  it { should accept_nested_attributes_for(:nested_config_items) }
end
