class CreateLists < ActiveRecord::Migration[5.0]
  def change
    create_table :lists do |t|
      t.references :user, foreign_key: true, null: false
      t.string :name
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
