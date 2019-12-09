class Plato < ApplicationRecord
  has_one_attached :picture
  has_many :contiene_platos
    has_many :platos, :through => :contiene_platos
end
