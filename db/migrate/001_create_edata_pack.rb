class CreateEdataPack < ActiveRecord::Migration[5.0]
  def change
    create_table :edata_packs, id: :string, limit: 36 do |t|
      t.timestamps
    end
  end
end
