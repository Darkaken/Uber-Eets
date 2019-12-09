class Usuario < ApplicationRecord
  has_one_attached :image
  has_many :ordens
  has_many :restaurante_favoritos
    has_many :restaurantes, :through => :restaurante_favoritos
  has_many :comentario_restaurantes
    has_many :restaurantes, :through => :comentario_restaurantes

end
