class AddColumnEstadoToRestaurantes < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurantes, :estado, :int
  end
end
