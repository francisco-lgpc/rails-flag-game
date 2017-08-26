class GamesController < ApplicationController
  def new
    @game = Game.new(mode: params[:game_mode])
    generate_map
  end

  private

  def generate_map
    worldize = Worldize::Countries.new
    img = worldize.draw(ocean: '#3A3C3C', land: 'grey', border: 'black', 'Portugal' => 'red') # Magick::Image of RMagick
    img.write('app/assets/images/map.png')
  end
end
