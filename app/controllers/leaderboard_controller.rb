class LeaderboardController < ApplicationController
  def index
    @games = Game.where(mode: params[:game_mode]).order(:score).reverse.first(10)
    p @games
    respond_to do |format|
      format.js
      format.html
    end
  end
end
