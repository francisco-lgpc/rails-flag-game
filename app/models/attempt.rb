class Attempt < ApplicationRecord
  belongs_to :question
  belongs_to :country
  validates :correct, inclusion: { in: [ true, false ] }
end
