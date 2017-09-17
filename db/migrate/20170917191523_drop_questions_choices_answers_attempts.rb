class DropQuestionsChoicesAnswersAttempts < ActiveRecord::Migration[5.0]
  def change
  	drop_table :choices
  	drop_table :attempts
  	drop_table :answers
  	drop_table :questions
  end
end
