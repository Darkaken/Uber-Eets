class CreateRestauranteFavoritos < ActiveRecord::Migration[5.2]
  def change
    create_join_table :usuarios, :restaurantes, table_name: :restaurante_favoritos do |t|
      t.index [:usuario_id, :restaurante_id]
      t.index [:restaurante_id, :usuario_id]
    end
  end
end
