class LeaderboardController < ApplicationController
  skip_before_action :authenticate_user!
  def index
  	game_mode = params[:game_mode] || 1
    @games = Game.where(mode: game_mode).order(:score).reverse.first(10)
    respond_to do |format|
      format.js
      format.html
    end
  end
end
