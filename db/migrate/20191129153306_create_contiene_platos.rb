class CreateContienePlatos < ActiveRecord::Migration[5.2]
  def change
    create_join_table :ordens, :platos, table_name: :contiene_platos do |t|
      t.integer :cantidad
      t.index [:orden_id, :plato_id]
      t.index [:plato_id, :orden_id]
    end
  end
end
