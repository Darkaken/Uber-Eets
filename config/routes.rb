Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #Homepage and guest dashboard
  root to: "public#homepage"
  get "/dashboard" => "public#dashboard"
  get "/dashboard/:id" => "public#view_restaurant"

  #Get login and enter login data
  get "/login/:msg" => "public#login_page"
  post "/login" => "public#login_user"

  # Admin stuff
  get "/admin" => "public#admin"
  get "/info_rest/:id" => "public#info_rest"
  post "/admin" => "public#admin"

  #Get signup and enter register data
  get "/signup" => "public#signup"
  post "/signup" => "public#signup"
  get "/exitosignup" => "public#exitosignup"

  # User Routes
  get "/userdashboard/:data" => "usuarios#dashboard"
  get "/userdashboard/:data/perfil" => "usuarios#perfil"
  post "/userdashboard/:data/perfil" => "usuarios#perfil"
  get "/userdashboard/:data/ordenes" => "usuarios#ordenes"

  get "/userdashboard/:data/:id" => "usuarios#pedido" #Se crea el Pedido
  post "/userdashboard/:data/:id" => "usuarios#confirmacion_pedido" #Se confirma el Pedido
  post "/userdashboard/:data/:id/confirm" => "usuarios#pedido"  #Se hacen los cambios de db

  # Restaurant Routes
  get "/restaurantdashboard/:id" => "restaurantes#dashboard"

  # Platos
  get "/crear_plato/:id" => "restaurantes#crear_plato"
  post "/crear_plato/:id" => "restaurantes#crear_plato"
  get "/info_plato/:id_rest/:id" => "restaurantes#detalles_plato"
  post "/eliminar_plato/:id_rest/:id_plato" => "restaurantes#eliminar_plato"

  # Perfil
  get "/restaurantprofile/:id" => "restaurantes#perfil"
  post "/restaurantprofile/:id" => "restaurantes#perfil"

end
