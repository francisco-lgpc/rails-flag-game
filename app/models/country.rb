class Country < ApplicationRecord
  validates :name, :code, :flag, presence: true

  def self.available_on_map
    available_contries = File.open("db/available_countries.txt").map do |line|
      line[0, 2]
    end
    self.where(code: available_contries)
  end
end
