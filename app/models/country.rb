class Country < ApplicationRecord
  validates :name, :code, :flag, presence: true
end
