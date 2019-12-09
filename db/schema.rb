# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_09_194422) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "comentario_platos", id: false, force: :cascade do |t|
    t.bigint "usuario_id", null: false
    t.bigint "plato_id", null: false
    t.datetime "fecha"
    t.float "puntaje"
    t.text "contenido"
    t.index ["plato_id", "usuario_id"], name: "index_comentario_platos_on_plato_id_and_usuario_id"
    t.index ["usuario_id", "plato_id"], name: "index_comentario_platos_on_usuario_id_and_plato_id"
  end

  create_table "comentario_restaurantes", force: :cascade do |t|
    t.bigint "usuario_id", null: false
    t.bigint "restaurante_id", null: false
    t.datetime "fecha"
    t.float "puntaje"
    t.text "contenido"
    t.index ["restaurante_id", "usuario_id"], name: "index_comentario_restaurantes_on_restaurante_id_and_usuario_id"
    t.index ["usuario_id", "restaurante_id"], name: "index_comentario_restaurantes_on_usuario_id_and_restaurante_id"
  end

  create_table "contiene_platos", id: false, force: :cascade do |t|
    t.bigint "orden_id", null: false
    t.bigint "plato_id", null: false
    t.integer "cantidad"
    t.index ["orden_id", "plato_id"], name: "index_contiene_platos_on_orden_id_and_plato_id"
    t.index ["plato_id", "orden_id"], name: "index_contiene_platos_on_plato_id_and_orden_id"
  end

  create_table "ordens", force: :cascade do |t|
    t.integer "medio_pago"
    t.string "direccion_entrega"
    t.datetime "hora_entrega"
    t.boolean "estado"
    t.text "notas"
    t.bigint "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "precio"
    t.index ["usuario_id"], name: "index_ordens_on_usuario_id"
  end

  create_table "platos", force: :cascade do |t|
    t.string "nombre"
    t.integer "precio"
    t.text "descripcion"
    t.integer "porciones"
    t.string "imagen"
    t.bigint "restaurante_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurante_id"], name: "index_platos_on_restaurante_id"
  end

  create_table "rest_favs", force: :cascade do |t|
    t.string "usuario_id"
    t.string "restaurante_id"
  end

  create_table "restaurante_favoritos", id: false, force: :cascade do |t|
    t.bigint "usuario_id", null: false
    t.bigint "restaurante_id", null: false
    t.index ["restaurante_id", "usuario_id"], name: "index_restaurante_favoritos_on_restaurante_id_and_usuario_id"
    t.index ["usuario_id", "restaurante_id"], name: "index_restaurante_favoritos_on_usuario_id_and_restaurante_id"
  end

  create_table "restaurantes", force: :cascade do |t|
    t.string "nombre"
    t.string "correo"
    t.string "direccion"
    t.float "valoracion"
    t.string "imagen"
    t.string "telefono"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password"
    t.integer "estado"
  end

  create_table "usuarios", force: :cascade do |t|
    t.integer "tipo"
    t.string "nombre"
    t.string "correo"
    t.string "direccion"
    t.string "imagen"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password"
    t.string "telefono"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "ordens", "usuarios"
  add_foreign_key "platos", "restaurantes"
end
