class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    worldize = Worldize::Countries.new
    img = worldize.draw(ocean: '#3A3C3C', land: 'grey', border: 'black', 'Portugal' => 'red') # Magick::Image of RMagick
    img.write('app/assets/images/map.png')
  end
end
