class CreateSchemes < ActiveRecord::Migration
  def change
    create_table :schemes do |t|
      t.string :name
      t.boolean :private
      t.boolean :shared

      t.timestamps null: false
    end
  end
end
