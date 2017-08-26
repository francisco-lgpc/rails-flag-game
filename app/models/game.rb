class Game < ApplicationRecord
  belongs_to :user
  MODES = ['Country to Flag', 'Country to Map', 'Flag to Country',
                'Flag to Map',     'Map to Country', 'Map to Flag']
end
