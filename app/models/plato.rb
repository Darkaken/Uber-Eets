class Plato < ApplicationRecord
  belongs_to :restaurante
  has_many :contiene_platos
    has_many :platos, :through => :contiene_platos
  has_many :comentario_platos
    has_many :usuarios, :through => :comentario_platos
end
