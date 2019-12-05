class CreateComentarioRestaurantes < ActiveRecord::Migration[5.2]
  def change
    create_join_table :usuarios, :restaurantes, table_name: :comentario_restaurantes do |t|
      t.timestamp :fecha
      t.float :puntaje
      t.text :contenido
      t.index [:usuario_id, :restaurante_id]
      t.index [:restaurante_id, :usuario_id]
    end
  end
end
