class CreateComentarioPlatos < ActiveRecord::Migration[5.2]
  def change
    create_join_table :usuarios, :platos, table_name: :comentario_platos do |t|
      t.timestamp :fecha
      t.float :puntaje
      t.text :contenido
      t.index [:usuario_id, :plato_id]
      t.index [:plato_id, :usuario_id]
    end
  end
end
