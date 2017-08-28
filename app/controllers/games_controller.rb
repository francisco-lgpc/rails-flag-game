require 'open-uri'
class GamesController < ApplicationController
  # before_action :set_game, except: [:create]

  def new
  end

  def create
    @game = Game.create!(mode: params[:game_mode], user: current_user)
    send(@game.mode_path)
    redirect_to @game
  end

  def show
    @game = Game.find(params[:id])
    @question = @game.questions.find do |question|
      question.not_answered?
    end
  end

  private

  def country_to_flag
    generate_questions
  end

  def country_to_map

  end

  def flag_to_country

  end

  def flag_to_map

  end

  def map_to_country

  end

  def map_to_flag

  end

  def sample_countries(n = 12)
    Country.where(id: Country.ids.sample(n))
  end

  def generate_choices_and_answer(question, n = 12)
    countries = sample_countries(n)
    countries.map do |country|
      Choice.create!(country: country, question: question)
    end
    Answer.create!(country: countries.sample, question: question)
  end

  def generate_questions(n = 15)
    (1..n).map do
      question = Question.create!(game: @game)
      generate_choices_and_answer(question)
    end
  end


  def set_game
    @game = Game.new(mode: params[:game_mode], user: current_user)
  end

  def generate_map
    worldize = Worldize::Countries.new
    img = worldize.draw(ocean: '#3A3C3C', land: 'grey', border: 'black', 'Portugal' => 'red') # Magick::Image of RMagick
    img.write('app/assets/images/map.png')
  end

end
