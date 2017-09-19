class GamesController < ApplicationController
  def new
    @game = Game.new(mode: params[:game_mode], user: current_user)
    session[:game] = {} if session[:game].nil? || session[:game]['mode'] != @game.mode 
    
    session[:game]['mode']  ||= @game.mode
    session[:game]['score'] ||= 0

    options = @game.has_map? ? { for_map: true } : {}
    session[:game]['questions'] ||= Game.generate_questions(15, 12, options)
    
    question  = Game.next_question(session[:game]['questions'])
    @question = Game.retrieve_country_objects(question) unless question.nil?
  end

  def create
    @game = Game.new(session[:game])
    @game.user = current_user
    @game.save!

    session[:game] = {}
    render js: "window.location.replace(#{game_path(@game).to_json})" 
  end

  def show
    @game = Game.find(params[:id])
  end
end
