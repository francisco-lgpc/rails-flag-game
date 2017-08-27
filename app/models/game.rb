class Game < ApplicationRecord
  belongs_to :user
  after_initialize :load_defaults
  validates :score, :mode, presence: true, numericality: { only_integer: true }

  MODES = ['Country to Flag', 'Country to Map', 'Flag to Country',
                'Flag to Map',     'Map to Country', 'Map to Flag']

  def mode_path
    MODES[mode - 1].to_snake
  end

  def mode_name
    MODES[mode - 1]
  end

  private

  def load_defaults
    self.score = 0
  end
end
