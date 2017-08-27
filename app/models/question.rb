class Question < ApplicationRecord
  belongs_to :game
  has_many :choices, dependent: :destroy
  has_one :attempt, dependent: :destroy
  has_one :answer, dependent: :destroy

  def answered?
    self.answered
  end

  def not_answered?
    !self.answered
  end
end
