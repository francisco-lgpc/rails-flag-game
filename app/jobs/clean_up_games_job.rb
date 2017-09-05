class CleanUpGamesJob < ApplicationJob
  queue_as :default

  def perform
    incomplete_games = Game.includes(:questions).where.not(
      questions: { answered: true }
    ).distinct.where(
      "games.created_at < ?", 1.day.ago
    )

    delete_children_and_self(incomplete_games)

    # Sub-optimal raw ruby alternativ
    # Game.all.reject { |game| game.questions.all?(&:answered) }
  end

  private

  def delete_children_and_self(games)
    games.each do |g|
      g.questions.each do |q|
        q.answer.try(:delete)
        q.attempt.try(:delete)
        q.choices.try(:delete_all)
        q.delete
      end unless g.questions.empty?
      g.delete
    end unless games.empty?
  end
end
