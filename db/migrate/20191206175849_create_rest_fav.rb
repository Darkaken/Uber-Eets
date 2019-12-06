class CreateRestFav < ActiveRecord::Migration[5.2]
  def change
    create_table :rest_favs do |t|
      t.string :usuario_id
      t.string :restaurate_id
    end
  end
end
