class CreateEdataConfigItem < ActiveRecord::Migration[5.0]
  def change
    create_table :edata_config_items, id: :string, limit: 36 do |t|
      t.string :edata_definition_id, limit: 36, null: false
      t.string :edata_config_id, limit: 36, null: false
      t.integer :sort
      t.boolean :is_visible, default: true
      t.boolean :is_required, default: false
      t.boolean :is_editable, default: true
      t.json :config
      t.string :parent_edata_config_item_id, limit: 36

      t.timestamps
    end

    add_index :edata_config_items, :edata_definition_id
    add_index :edata_config_items, :edata_config_id
    add_index :edata_config_items, :parent_edata_config_item_id, name: 'index_config_items_on_parent_item'

    add_foreign_key :edata_config_items, :edata_definitions, column: :edata_definition_id
    add_foreign_key :edata_config_items, :edata_configs, column: :edata_config_id
    add_foreign_key :edata_config_items, :edata_config_items, column: :parent_edata_config_item_id
  end
end
