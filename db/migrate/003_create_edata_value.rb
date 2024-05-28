class CreateEdataValue < ActiveRecord::Migration[5.0]
  def change
    create_table :edata_values, id: :string, limit: 36 do |t|
      t.string :edata_pack_id, limit: 36, null: false
      t.string :edata_definition_id, limit: 36, null: false
      t.string :event
      t.boolean :is_latest, default: true
      t.string :value
      t.text :value_text
      t.datetime :value_datetime
      t.json :value_json
      t.string :data_pointer
      t.string :login_id
      t.json :meta

      t.timestamps
    end

    add_index :edata_values, :edata_pack_id
    add_index :edata_values, :edata_definition_id
    add_foreign_key :edata_values, :edata_packs, column: :edata_pack_id
    add_foreign_key :edata_values, :edata_definitions, column: :edata_definition_id
  end
end
