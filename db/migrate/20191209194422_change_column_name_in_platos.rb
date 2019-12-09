class ChangeColumnNameInPlatos < ActiveRecord::Migration[5.2]
  def change
    rename_column :platos, :image, :imagen
  end
end
