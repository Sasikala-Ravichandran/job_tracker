class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :employer
      t.integer :reg_id
      t.date :open_date
      t.date :close_date
      t.date :applied_date
      t.date :interview_date
      t.text :notes
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
