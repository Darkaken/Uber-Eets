Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #Homepage and guest dashboard
  root to: "public#homepage"

  get "/:msg" => "public#homepage"

  get "/dashboard" => "public#dashboard"
  get "/dashboard/:id" => "public#view_restaurant"

  #Get login and enter login data
  get "/login/:msg" => "public#login_page"
  post "/login" => "public#login_user"

  # Admin stuff
  get "/users/admin" => "public#admin"
  get "/info_rest/:id" => "public#info_rest"
  post "/users/admin" => "public#admin"
  get "/admin/stats" => "public#stats"

  #Get signup and enter register data
  get "/signup" => "public#signup"
  post "/signup" => "public#signup"

  # USER ROUTES
  get "/userdashboard/:data/:msg" => "usuarios#dashboard"

  # Perfil
  get "/userdashboard/:data/perfil" => "usuarios#perfil"
  post "/userdashboard/:data/perfil" => "usuarios#perfil"

  patch "/userdashboard/:data/perfil/cambiar_img" => "usuarios#cambiar_img"

  # Ordenes
  get "/userdashboard/:data/ordenes" => "usuarios#ordenes"
  get "/userdashboard/:data/ordenes/:orden_id" => "usuarios#detalle_orden"

  # Pedidos
  get "/userdashboard/:data/:id" => "usuarios#pedido" #Se crea el Pedido
  post "/userdashboard/:data/:id" => "usuarios#confirmacion_pedido" #Se confirma el Pedido
  post "/userdashboard/:data/:id/confirm" => "usuarios#pedido"  #Se hacen los cambios de db

  # Ver Restaurantes

  get "/userdashboard/:data/:id/view" => "usuarios#view_restaurant"
  post "/userdashboard/:data/:id/view" => "usuarios#view_restaurant"

  # RESTAURANT ROUTES
  get "/restaurantdashboard/:id" => "restaurantes#dashboard"

  # Platos
  get "/crear_plato/:id" => "restaurantes#crear_plato"
  post "/crear_plato/:id" => "restaurantes#crear_plato"
  post "/eliminar_plato/:id_rest/:id_plato" => "restaurantes#eliminar_plato"

  # Detalles Plato
  get "/info_plato/:id_rest/:id" => "restaurantes#detalles_plato"
  patch "/info_plato/:id_rest/:id/cambiar_img" => "restaurantes#cambiar_img_plato"

  # Ordenes

  get "/restaurantdashboard/:id/:id_orden" => "restaurantes#orden"
  post "/restaurantdashboard/:id/:id_orden" => "restaurantes#orden"

  # Perfil
  get "/restaurantprofile/:id" => "restaurantes#perfil"
  post "/restaurantprofile/:id" => "restaurantes#perfil"
  patch "/restaurantprofile/:id/cambiar_img" => "restaurantes#cambiar_img_rest"

end
