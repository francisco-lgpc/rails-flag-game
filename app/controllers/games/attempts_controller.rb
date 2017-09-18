class Games::AttemptsController < ApplicationController
  def create
    question_idx = session[:game]['questions'].find { |question| !question['answered'] }['question']

    attempt = Country.where(id: params[:country_id]).ids.first || Country.find_by(code: params['country_code']).id
    answer  = session[:game]['questions'][question_idx]['answer']
    
    session[:game]['questions'][question_idx]['attempt']  = attempt
    session[:game]['questions'][question_idx]['correct']  = attempt == answer
    session[:game]['questions'][question_idx]['answered'] = true
    
    session[:game]['score'] += 1 if attempt == answer

    question  = session[:game]['questions'][question_idx]
    @question = Game.retrieve_country_objects(question)

    respond_to do |format|
      format.js
      format.html { redirect_to new_game_path }
    end
  end
end