class CreateEdataConfig < ActiveRecord::Migration[5.0]
  def change
    create_table :edata_configs, id: :string, limit: 36 do |t|
      t.string :name, null: false
      t.string :description
      t.timestamps
    end
  end
end
