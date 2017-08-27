class AttemptsController < ApplicationController
  def create
    question = Question.find(params[:question_id])

    attempt = Attempt.new(question: question)
    attempt.country = Country.find(params[:country_id])
    attempt.correct = attempt.country.id == question.answer.country.id
    attempt.save!

    question.answered = true
    question.save!

    question.game.score += 1 if attempt.correct
    question.game.save!

    redirect_to question.game
  end
end
