class CreateEdataDefinition < ActiveRecord::Migration[5.0]
  def change
    create_table :edata_definitions, id: :string, limit: 36 do |t|
      t.string :name, null: false
      t.boolean :is_sensitive, default: false
      t.string :data_type
      t.string :label
      t.string :edata_pack_id, limit: 36, index: true

      t.timestamps
    end

    add_foreign_key :edata_definitions, :edata_packs, column: :edata_pack_id
  end
end
