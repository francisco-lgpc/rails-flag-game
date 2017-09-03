class CleanUpGamesJob < ApplicationJob
  queue_as :default

  def perform
    puts 'do stuff'
  end
end
