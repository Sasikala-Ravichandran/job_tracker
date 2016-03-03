class CreateApplieds < ActiveRecord::Migration
  def change
    create_table :applieds do |t|
      t.references :document, index: true, foreign_key: true
      t.references :position, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
