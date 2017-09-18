require 'open-uri'
class GamesController < ApplicationController
  # before_action :set_game, except: [:create]

  def new
    @game = Game.new(mode: params[:game_mode], user: current_user)
    session[:game] = {} if session[:game].nil? || session[:game]['mode'] != @game.mode 
    
    session[:game]['mode']  = @game.mode
    session[:game]['score'] ||= 0
    send(@game.mode_path)
    
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

  private

  def country_to_flag
    session[:game]['questions'] ||= Game.generate_questions
  end

  def country_to_map
    session[:game]['questions'] ||= Game.generate_questions(15, 12, for_map: true)
  end

  def flag_to_country
    session[:game]['questions'] ||= Game.generate_questions
  end

  def flag_to_map
    session[:game]['questions'] ||= Game.generate_questions(15, 12, for_map: true)
  end

  def map_to_country
    session[:game]['questions'] ||= Game.generate_questions(15, 12, for_map: true)
  end

  def map_to_flag
    session[:game]['questions'] ||= Game.generate_questions(15, 12, for_map: true)
  end
end
