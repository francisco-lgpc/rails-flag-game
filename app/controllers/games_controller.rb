require 'open-uri'
class GamesController < ApplicationController
  # before_action :set_game, except: [:create]

  def new
  end

  def create
    @game = Game.create!(mode: params[:game_mode], user: current_user)
    send(@game.mode_path)
    session[:game] = {                 
      questions: @game.questions,
      score: @game.score,
      mode: @game.mode,    
    }
    redirect_to @game
  end

  def show
    @game     = Game.find(params[:id])
    question  = Game.next_question(session[:game]['questions'])
    @question = Game.retrieve_country_objects(question) unless question.nil?
  end

  private

  def country_to_flag
    @game.generate_questions
  end

  def country_to_map
    @game.generate_questions(15, 12, for_map: true)
  end

  def flag_to_country
    @game.generate_questions
  end

  def flag_to_map
    @game.generate_questions(15, 12, for_map: true)
  end

  def map_to_country
    @game.generate_questions(15, 12, for_map: true)
  end

  def map_to_flag
    @game.generate_questions(15, 12, for_map: true)
  end

  def set_game
    @game = Game.new(mode: params[:game_mode], user: current_user)
  end
end
