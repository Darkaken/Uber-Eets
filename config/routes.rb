Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #Homepage and guest dashboard
  root to: "public#homepage"
  get "/dashboard" => "public#dashboard"

  #Get login and enter login data
  get "/login" => "public#login_page"
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

  # Restaurant Routes
  get "/restaurantdashboard/:data" => "restaurantes#dashboard"
  get "/crear_plato/:id" => "restaurantes#crear_plato"
  post "/crear_plato/:id" => "restaurantes#crear_plato"
  get "/info_plato/:id_rest/:id_plato" => "restaurantes#detalles_plato"

end
