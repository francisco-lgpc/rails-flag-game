class LeaderboardController < ApplicationController
  def index
    @games = Game.where(mode: params[:game_mode]).order(:score).reverse.first(10)
  end
end
