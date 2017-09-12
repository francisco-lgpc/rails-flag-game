class AttemptsController < ApplicationController
  def create
    p params
    question = Question.find(params[:question_id])

    attempt = Attempt.new(question: question)

    attempt.country = Country.where(id: params[:country_id]).first || Country.find_by(code: params['country_code'])
    attempt.correct = attempt.country.id == question.answer.country.id
    attempt.save!

    question.answered = true
    question.save!

    question.game.score += 1 if attempt.correct
    question.game.save!

    @last_question = question
    @question = question.game.questions.find(&:not_answered?)

    respond_to do |format|
      format.js unless @question.nil?
      format.html { redirect_to question.game }
    end
  end
end
