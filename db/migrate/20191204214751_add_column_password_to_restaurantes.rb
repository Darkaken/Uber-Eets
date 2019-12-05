class AddColumnPasswordToRestaurantes < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurantes, :password, :string
  end
end
