class CreateColorsSchemes < ActiveRecord::Migration
  def change
    create_table :colors_schemes do |t|
      t.references :color, index: true, foreign_key: true
      t.references :scheme, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
