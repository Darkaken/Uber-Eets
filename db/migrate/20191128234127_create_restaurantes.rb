class CreateRestaurantes < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurantes do |t|
      t.string :nombre
      t.string :correo
      t.string :direccion
      t.float :valoracion
      t.string :imagen
      t.string :telefono

      t.timestamps
    end
  end
end
