class AddIdToComentariosRestaurante < ActiveRecord::Migration[5.2]
  def change
    add_column :comentario_restaurantes, :id, :primary_key
  end
end
