class CreateAttempts < ActiveRecord::Migration[5.0]
  def change
    create_table :attempts do |t|
      t.boolean :correct
      t.references :question, foreign_key: true
      t.references :country, foreign_key: true

      t.timestamps
    end
  end
end
