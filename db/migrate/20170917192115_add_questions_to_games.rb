class AddQuestionsToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :questions, :text
  end
end
