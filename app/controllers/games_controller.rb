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
    @question = @game.questions.find(&:not_answered?)
  end

  private

  def country_to_flag
    generate_questions
  end

  def country_to_map
    generate_questions(15, 12, for_map: true)
  end

  def flag_to_country
    generate_questions
  end

  def flag_to_map
    generate_questions(15, 12, for_map: true)
  end

  def map_to_country
    generate_questions(15, 12, for_map: true)
  end

  def map_to_flag
    generate_questions(15, 12, for_map: true)
  end

  def sample_countries(n = 12, options = {})
    countries = Country.where.not(id: options[:exclude].try(:id))
    if options[:for_map]
      countries.where(id: Country.available_on_map.ids.sample(n))
    else
      countries.where(id: Country.ids.sample(n))
    end
  end

  def generate_choices(question, answer_country, n = 12, options = {})
    options[:exclude] = answer_country
    countries = sample_countries(n - 1, options) + [answer_country]
    countries.shuffle.map do |country|
      Choice.create!(country: country, question: question)
    end
    Answer.create!(country: answer_country, question: question)
  end

  def generate_questions(num_questions = 15, num_choices = 12, options = {})
    answer_countries = sample_countries(num_questions, options)
    answer_countries.map do |answer_country|
      question = Question.create!(game: @game)
      generate_choices(question, answer_country, num_choices, options)
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
