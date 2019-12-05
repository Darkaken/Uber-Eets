class CreateOrdens < ActiveRecord::Migration[5.2]
  def change
    create_table :ordens do |t|
      t.integer :medio_pago
      t.string :direccion_entrega
      t.timestamp :hora_entrega
      t.boolean :estado
      t.text :notas
      t.references :usuario, foreign_key: true

      t.timestamps
    end
  end
end
