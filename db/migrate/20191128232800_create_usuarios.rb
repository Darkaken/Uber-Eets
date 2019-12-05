class CreateUsuarios < ActiveRecord::Migration[5.2]
  def change
    create_table :usuarios do |t|
      t.integer :tipo
      t.string :nombre
      t.string :correo
      t.string :direccion
      t.string :imagen

      t.timestamps
    end
  end
end
