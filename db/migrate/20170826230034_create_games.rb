class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :mode
      t.integer :score
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
