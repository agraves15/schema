class CreateSchemesUsers < ActiveRecord::Migration
  def change
    create_table :schemes_users do |t|
      t.references :scheme, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
