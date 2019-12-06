class RenameColumnRestaurateFromRestFavToRestaurante < ActiveRecord::Migration[5.2]
  def change
    rename_column :rest_favs, :restaurate_id, :restaurante_id
  end
end
