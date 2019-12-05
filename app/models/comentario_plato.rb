class ComentarioPlato < ApplicationRecord
  belongs_to :usuario
  belongs_to :plato
end
