class AddColumnTelefonoToUsuarios < ActiveRecord::Migration[5.2]
  def change
    add_column :usuarios, :telefono, :string
  end
end
