class AddColumnPrecioToOrdens < ActiveRecord::Migration[5.2]
  def change
    add_column :ordens, :precio, :int
  end
end
