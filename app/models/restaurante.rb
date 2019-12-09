class Restaurante < ApplicationRecord
  has_one_attached :avatar
  has_many :platos
  has_many :restaurante_favoritos
    has_many :usuarios, :through => :restaurante_favoritos
  has_many :comentario_restaurantes
    has_many :usuarios, :through => :comentario_restaurantes
end
