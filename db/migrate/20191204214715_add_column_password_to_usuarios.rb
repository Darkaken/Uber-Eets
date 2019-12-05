class AddColumnPasswordToUsuarios < ActiveRecord::Migration[5.2]
  def change
    add_column :usuarios, :password, :string
  end
end
