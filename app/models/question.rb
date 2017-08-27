class Question < ApplicationRecord
  belongs_to :game
  has_many :choices
  has_one :attempt
  has_one :answer
end
