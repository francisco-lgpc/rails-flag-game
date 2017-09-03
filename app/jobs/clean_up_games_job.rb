class CleanUpGamesJob < ApplicationJob
  queue_as :default

  def perform
    incomplete_games = Game.includes(:questions).where.not(
      questions: { answered: true }
    ).distinct.where(
      "games.created_at < ?", 1.day.ago
    )

    destroy_children_and_self(incomplete_games)

    # Sub-optimal raw ruby alternativ
    # Game.all.reject { |game| game.questions.all?(&:answered) }
  end

  private

  def destroy_children_and_self(games)
    unless games.map(&:questions).reduce(:+).nil?
      games.map(&:questions).reduce(:+).each do |q|
        q.answer.try(:destroy!)
        q.attempt.try(:destroy!)
        q.choices.try(:destroy_all)
      end
    end
    games.each(&:destroy)
  end

end
