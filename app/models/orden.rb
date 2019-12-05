class Orden < ApplicationRecord
  belongs_to :usuario
  has_many :contiene_platos
    has_many :platos, :through => :contiene_platos
end
