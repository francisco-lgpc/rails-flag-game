class CleanUpGamesJob < ApplicationJob
  queue_as :default

  def perform
    Game.where(score: 0).where("games.created_at < ?", 1.day.ago).destroy_all
  end
end
