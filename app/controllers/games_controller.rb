class GamesController < ApplicationController
  before_action :set_game, except: [:create]

  def new
    @game = Game.new(mode: params[:game_mode], user: current_user)
    send(@game.mode_path)
  end

  def create
  end

  private

  def set_game
    @game = Game.new(mode: params[:game_mode], user: current_user)
  end

  def generate_map
    worldize = Worldize::Countries.new
    img = worldize.draw(ocean: '#3A3C3C', land: 'grey', border: 'black', 'Portugal' => 'red') # Magick::Image of RMagick
    img.write('app/assets/images/map.png')
  end

  def country_to_flag

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

end
